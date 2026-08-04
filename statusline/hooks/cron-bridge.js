#!/usr/bin/env node
'use strict';

/**
 * cron-bridge
 *
 * Claude Code cron jobs (CronCreate) are session-only and in-memory, so the
 * statusline can't see them. This hook mirrors them into a per-session tmp
 * file that claude-cyberpunk-powerline --cron reads to render a countdown.
 *
 * Wired as:
 *   PostToolUse (CronCreate|CronDelete)  -> add/remove job
 *   SessionStart / SessionEnd            -> delete the bridge file (crons
 *                                           never survive the session)
 *
 * File: <tmpdir>/claude-cron-<session_id>.json
 *   { "session_id": "...", "jobs": [{ "id", "cron", "prompt", "recurring", "created_at" }] }
 */

const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');

const chunks = [];
process.stdin.on('data', (c) => chunks.push(c));
process.stdin.on('end', () => {
  try {
    handle(JSON.parse(Buffer.concat(chunks).toString('utf8')));
  } catch {
    // Never break the tool call over bridge bookkeeping.
  }
  process.exit(0);
});

function handle(payload) {
  const sessionId = payload.session_id;
  if (!sessionId) return;
  const bridgeFile = path.join(os.tmpdir(), `claude-cron-${sessionId}.json`);

  if (payload.hook_event_name !== 'PostToolUse') {
    fs.rmSync(bridgeFile, { force: true });
    return;
  }

  let jobs = [];
  try {
    jobs = JSON.parse(fs.readFileSync(bridgeFile, 'utf8')).jobs ?? [];
  } catch {
    // Missing or corrupt file — start fresh.
  }

  if (payload.tool_name === 'CronCreate') {
    const input = payload.tool_input ?? {};
    if (typeof input.cron !== 'string') return;
    // The job id is only present in the free-text tool response; best-effort
    // extraction so CronDelete can match it later.
    const responseText = JSON.stringify(payload.tool_response ?? '');
    const id = responseText.match(/\b(?:job[-_ ]?id|id)[":\s]*([A-Za-z0-9._-]{4,})/i)?.[1] ?? null;
    jobs.push({
      id,
      cron: input.cron,
      prompt: input.prompt ?? '',
      recurring: input.recurring !== false,
      created_at: Date.now(),
    });
  } else if (payload.tool_name === 'CronDelete') {
    const id = payload.tool_input?.id;
    if (!id) return;
    const remaining = jobs.filter((j) => j.id !== id);
    // Unmatched id (extraction failed at create time): drop the whole file
    // rather than keep rendering a countdown for a possibly-dead job.
    jobs = remaining.length === jobs.length ? [] : remaining;
  } else {
    return;
  }

  if (jobs.length === 0) {
    fs.rmSync(bridgeFile, { force: true });
  } else {
    fs.writeFileSync(bridgeFile, JSON.stringify({ session_id: sessionId, jobs }), 'utf8');
  }
}
