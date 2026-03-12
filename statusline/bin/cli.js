#!/usr/bin/env node
'use strict';

/**
 * claude-cyberpunk-powerline
 *
 * Reads Claude Code JSON from stdin, renders a true-color ANSI statusline,
 * and writes it to stdout.
 *
 * Usage:
 *   echo '<json>' | npx -y @pablobfonseca/claude-cyberpunk-powerline --style=storm
 *   echo '<json>' | npx -y @pablobfonseca/claude-cyberpunk-powerline --style=neon --git
 *   echo '<json>' | npx -y @pablobfonseca/claude-cyberpunk-powerline --duration --cache --vim-mode
 */

const { getPalette } = require('../lib/palettes.js');
const { renderStatusline } = require('../lib/render.js');

// ---------------------------------------------------------------------------
// CLI flag parsing — no dependencies, no over-engineering
// ---------------------------------------------------------------------------

/**
 * Extract the value of a --key=value flag from argv.
 * @param {string[]} args
 * @param {string} key
 * @param {string} defaultValue
 * @returns {string}
 */
function getFlag(args, key, defaultValue) {
  const prefix = `--${key}=`;
  const match = args.find((a) => a.startsWith(prefix));
  return match ? match.slice(prefix.length) : defaultValue;
}

const args = process.argv.slice(2);
const style = getFlag(args, 'style', 'storm');
const showGit = args.includes('--git');
const showDuration = args.includes('--duration');
const showCache = args.includes('--cache');
const showVimMode = args.includes('--vim-mode');
const palette = getPalette(style);

// ---------------------------------------------------------------------------
// Read stdin
// ---------------------------------------------------------------------------

const chunks = [];

process.stdin.on('data', (chunk) => chunks.push(chunk));

process.stdin.on('end', () => {
  const raw = Buffer.concat(chunks).toString('utf8').trim();

  if (!raw) {
    // Nothing piped — exit silently so shell prompt stays clean.
    process.exit(0);
  }

  let data;
  try {
    data = JSON.parse(raw);
  } catch {
    process.stderr.write(`claude-cyberpunk-powerline: invalid JSON on stdin\n`);
    process.exit(1);
  }

  process.stdout.write(
    renderStatusline(data, palette, {
      git: showGit,
      duration: showDuration,
      cache: showCache,
      vimMode: showVimMode,
    }) + '\n',
  );
});

process.stdin.on('error', () => {
  // stdin closed/broken — exit cleanly.
  process.exit(0);
});
