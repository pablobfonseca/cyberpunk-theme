'use strict';

/**
 * Minimal 5-field cron parser (minute hour day-of-month month day-of-week),
 * matching Claude Code's CronCreate contract: local time, standard semantics.
 * Supports "*", lists, ranges, and steps. No named months/days, no @macros.
 */

/**
 * Expand one cron field into a Set of allowed values.
 * @param {string} field
 * @param {number} min
 * @param {number} max
 * @returns {Set<number> | null}  null when the field is invalid
 */
function expandField(field, min, max) {
  const values = new Set();
  for (const part of field.split(',')) {
    const [rangePart, stepPart] = part.split('/');
    const step = stepPart === undefined ? 1 : Number(stepPart);
    if (!Number.isInteger(step) || step < 1) return null;

    let lo;
    let hi;
    if (rangePart === '*') {
      lo = min;
      hi = max;
    } else if (rangePart.includes('-')) {
      const [a, b] = rangePart.split('-').map(Number);
      lo = a;
      hi = b;
    } else {
      lo = Number(rangePart);
      hi = stepPart === undefined ? lo : max;
    }
    if (!Number.isInteger(lo) || !Number.isInteger(hi) || lo < min || hi > max || lo > hi) {
      return null;
    }
    for (let v = lo; v <= hi; v += step) values.add(v);
  }
  return values;
}

/**
 * Parse a 5-field cron expression.
 * @param {string} expr
 * @returns {{ minute: Set<number>, hour: Set<number>, dom: Set<number>, month: Set<number>, dow: Set<number>, domRestricted: boolean, dowRestricted: boolean } | null}
 */
function parseCron(expr) {
  const fields = expr.trim().split(/\s+/);
  if (fields.length !== 5) return null;

  const minute = expandField(fields[0], 0, 59);
  const hour = expandField(fields[1], 0, 23);
  const dom = expandField(fields[2], 1, 31);
  const month = expandField(fields[3], 1, 12);
  const dow = expandField(fields[4], 0, 7);
  if (!minute || !hour || !dom || !month || !dow) return null;

  // Cron allows both 0 and 7 for Sunday.
  if (dow.has(7)) dow.add(0);

  return {
    minute,
    hour,
    dom,
    month,
    dow,
    domRestricted: fields[2] !== '*',
    dowRestricted: fields[4] !== '*',
  };
}

/**
 * Standard cron day matching: when both day-of-month and day-of-week are
 * restricted, a date matches if EITHER matches.
 * @param {ReturnType<typeof parseCron>} spec
 * @param {Date} date
 * @returns {boolean}
 */
function dayMatches(spec, date) {
  const domOk = spec.dom.has(date.getDate());
  const dowOk = spec.dow.has(date.getDay());
  if (spec.domRestricted && spec.dowRestricted) return domOk || dowOk;
  return domOk && dowOk;
}

const SEARCH_LIMIT_MINUTES = 366 * 24 * 60;

/**
 * Compute the next fire time strictly after `from`.
 * @param {string} expr  5-field cron expression in local time
 * @param {Date} [from]
 * @returns {Date | null}  null when the expression is invalid or never matches
 */
function nextRun(expr, from = new Date()) {
  const spec = parseCron(expr);
  if (!spec) return null;

  const t = new Date(from.getFullYear(), from.getMonth(), from.getDate(), from.getHours(), from.getMinutes());
  t.setMinutes(t.getMinutes() + 1);

  for (let i = 0; i < SEARCH_LIMIT_MINUTES; i++) {
    if (!spec.month.has(t.getMonth() + 1)) {
      t.setMonth(t.getMonth() + 1, 1);
      t.setHours(0, 0);
      continue;
    }
    if (!dayMatches(spec, t)) {
      t.setDate(t.getDate() + 1);
      t.setHours(0, 0);
      continue;
    }
    if (!spec.hour.has(t.getHours())) {
      t.setHours(t.getHours() + 1, 0);
      continue;
    }
    if (!spec.minute.has(t.getMinutes())) {
      t.setMinutes(t.getMinutes() + 1);
      continue;
    }
    return t;
  }
  return null;
}

module.exports = { nextRun };
