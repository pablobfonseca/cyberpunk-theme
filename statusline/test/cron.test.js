'use strict';

const { test } = require('node:test');
const assert = require('node:assert');
const { nextRun } = require('../lib/cron.js');

// All dates local time: new Date(year, monthIndex, day, hour, minute)
const from = new Date(2026, 7, 4, 18, 20); // Tue Aug 4 2026, 18:20

test('every 5 minutes', () => {
  assert.deepStrictEqual(nextRun('*/5 * * * *', from), new Date(2026, 7, 4, 18, 25));
});

test('hourly at minute 7', () => {
  assert.deepStrictEqual(nextRun('7 * * * *', from), new Date(2026, 7, 4, 19, 7));
});

test('daily time already passed today rolls to tomorrow', () => {
  assert.deepStrictEqual(nextRun('0 9 * * *', from), new Date(2026, 7, 5, 9, 0));
});

test('weekdays at 9am from a Tuesday evening', () => {
  assert.deepStrictEqual(nextRun('0 9 * * 1-5', from), new Date(2026, 7, 5, 9, 0));
});

test('weekday rule skips the weekend', () => {
  const friday = new Date(2026, 7, 7, 10, 0);
  assert.deepStrictEqual(nextRun('0 9 * * 1-5', friday), new Date(2026, 7, 10, 9, 0));
});

test('pinned one-shot date in the future', () => {
  assert.deepStrictEqual(nextRun('30 14 28 8 *', from), new Date(2026, 7, 28, 14, 30));
});

test('pinned date already passed wraps to next year', () => {
  assert.deepStrictEqual(nextRun('30 14 1 2 *', from), new Date(2027, 1, 1, 14, 30));
});

test('minute list', () => {
  assert.deepStrictEqual(nextRun('0,15,45 * * * *', from), new Date(2026, 7, 4, 18, 45));
});

test('range with step', () => {
  assert.deepStrictEqual(nextRun('10-50/20 * * * *', from), new Date(2026, 7, 4, 18, 30));
});

test('dom OR dow when both are restricted (standard cron semantics)', () => {
  // Aug 5 2026 is a Wednesday (dow 3). "* * 20 * 3" matches the 20th OR Wednesdays.
  assert.deepStrictEqual(nextRun('0 0 20 * 3', from), new Date(2026, 7, 5, 0, 0));
});

test('dow 7 treated as Sunday', () => {
  assert.deepStrictEqual(nextRun('0 12 * * 7', from), new Date(2026, 7, 9, 12, 0));
});

test('next run is strictly after "from" even on an exact match', () => {
  const exact = new Date(2026, 7, 4, 18, 25);
  assert.deepStrictEqual(nextRun('*/5 * * * *', exact), new Date(2026, 7, 4, 18, 30));
});

test('invalid expression returns null', () => {
  assert.strictEqual(nextRun('not a cron', from), null);
  assert.strictEqual(nextRun('* * * *', from), null);
  assert.strictEqual(nextRun('61 * * * *', from), null);
});
