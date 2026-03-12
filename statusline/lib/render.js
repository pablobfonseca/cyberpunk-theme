'use strict';

const { execSync } = require('node:child_process');
const fs = require('node:fs');
const path = require('node:path');

// ---------------------------------------------------------------------------
// ANSI helpers
// ---------------------------------------------------------------------------

/**
 * Parse a hex color string into its RGB components.
 * @param {string} hex  e.g. "#ff007f"
 * @returns {{ r: number, g: number, b: number }}
 */
function hexToRgb(hex) {
  const n = parseInt(hex.replace('#', ''), 16);
  return { r: (n >> 16) & 0xff, g: (n >> 8) & 0xff, b: n & 0xff };
}

/**
 * Wrap text in a true-color ANSI foreground sequence and reset afterward.
 * @param {string} text
 * @param {string} hex
 * @param {boolean} [bold]
 * @returns {string}
 */
function color(text, hex, bold = false) {
  const { r, g, b } = hexToRgb(hex);
  const boldSeq = bold ? '\x1b[1m' : '';
  return `${boldSeq}\x1b[38;2;${r};${g};${b}m${text}\x1b[0m`;
}

// ---------------------------------------------------------------------------
// Git branch with 5-second file-based cache
// ---------------------------------------------------------------------------

const GIT_CACHE_FILE = path.join(
  process.env.TMPDIR || process.env.TMP || '/tmp',
  'claude-cyberpunk-powerline-git-branch.json',
);
const GIT_CACHE_TTL_MS = 5_000;

/**
 * Resolve the current git branch, using a short-lived tmp-file cache to
 * avoid spawning a child process on every render tick.
 * Returns an empty string when git is unavailable or the cwd is not a repo.
 *
 * Security note: cwd is passed as an option to execSync, not shell-interpolated.
 * The git command string itself is a hardcoded literal.
 *
 * @param {string} cwd  directory to run git in
 * @returns {string}
 */
function gitBranch(cwd) {
  // Try reading the cache first.
  try {
    const raw = fs.readFileSync(GIT_CACHE_FILE, 'utf8');
    const cache = JSON.parse(raw);
    if (
      cache.cwd === cwd &&
      typeof cache.branch === 'string' &&
      Date.now() - cache.ts < GIT_CACHE_TTL_MS
    ) {
      return cache.branch;
    }
  } catch {
    // Cache miss or corrupt — fall through to git.
  }

  let branch = '';
  try {
    // The command is a hardcoded literal; cwd is an option, not interpolated.
    branch = execSync('git branch --show-current', {
      cwd,
      stdio: ['ignore', 'pipe', 'ignore'],
      timeout: 2_000,
    })
      .toString()
      .trim();
  } catch {
    // git not available, or not a git repo — leave branch as empty string.
  }

  try {
    fs.writeFileSync(
      GIT_CACHE_FILE,
      JSON.stringify({ cwd, branch, ts: Date.now() }),
      'utf8',
    );
  } catch {
    // Non-fatal: /tmp write failure just skips caching.
  }

  return branch;
}

// ---------------------------------------------------------------------------
// Context bar
// ---------------------------------------------------------------------------

const BAR_WIDTH = 10;

/**
 * Build the filled/empty block progress bar and choose a color based on the
 * used percentage.
 * @param {number} usedPct  0-100
 * @param {import('./palettes').Palette} palette
 * @returns {string}  colored ANSI string
 */
function contextBar(usedPct, palette) {
  const filled = Math.round((usedPct / 100) * BAR_WIDTH);
  const bar = '\u2588'.repeat(filled) + '\u2591'.repeat(BAR_WIDTH - filled);

  let barColor;
  if (usedPct < 50) {
    barColor = palette.neon_cyan;
  } else if (usedPct < 70) {
    barColor = palette.neon_green;
  } else if (usedPct < 85) {
    barColor = palette.neon_yellow;
  } else if (usedPct < 95) {
    barColor = palette.neon_orange;
  } else {
    barColor = palette.neon_pink;
  }

  return `${color(bar, barColor)} ${color(`${Math.round(usedPct)}%`, barColor)}`;
}

// ---------------------------------------------------------------------------
// Token formatting
// ---------------------------------------------------------------------------

/**
 * Format a token count into a compact human-readable string.
 * e.g. 1234 → "1.2k", 56789 → "56.8k", 1234567 → "1.2M"
 * @param {number} count
 * @returns {string}
 */
function formatTokenCount(count) {
  if (count >= 1_000_000) return `${(count / 1_000_000).toFixed(1)}M tok`;
  if (count >= 1_000) return `${(count / 1_000).toFixed(1)}k tok`;
  return `${count} tok`;
}

// ---------------------------------------------------------------------------
// Duration formatting
// ---------------------------------------------------------------------------

/**
 * Format a duration in milliseconds into a compact human-readable string.
 * e.g. 45000 → "45s", 74500 → "1m14s", 500 → "<1s"
 * @param {number} ms
 * @returns {string}
 */
function formatDuration(ms) {
  if (ms < 1_000) return '<1s';
  const totalSecs = Math.floor(ms / 1_000);
  if (totalSecs < 60) return `${totalSecs}s`;
  const mins = Math.floor(totalSecs / 60);
  const secs = totalSecs % 60;
  return `${mins}m${String(secs).padStart(2, '0')}s`;
}

// ---------------------------------------------------------------------------
// Main render
// ---------------------------------------------------------------------------

/**
 * @typedef {Object} ContextUsage
 * @property {number} [cache_read_input_tokens]
 * @property {number} [cache_creation_input_tokens]
 * @property {number} [input_tokens]
 */

/**
 * @typedef {Object} StatusData
 * @property {{ display_name?: string, id?: string }} [model]
 * @property {{ used_percentage?: number, total_input_tokens?: number, total_output_tokens?: number, current_usage?: ContextUsage }} [context_window]
 * @property {{ total_cost_usd?: number, total_lines_added?: number, total_lines_removed?: number, total_duration_ms?: number, total_api_duration_ms?: number }} [cost]
 * @property {{ current_dir?: string, project_dir?: string }} [workspace]
 * @property {{ mode?: string }} [vim]
 * @property {string} [session_id]
 */

/**
 * @typedef {Object} RenderOptions
 * @property {boolean} [git]       Show git branch segment (default: false)
 * @property {boolean} [duration]  Show session duration segment (default: false)
 * @property {boolean} [cache]     Show cache hit ratio segment (default: false)
 * @property {boolean} [vimMode]   Show vim mode segment (default: false)
 */

/**
 * Render a single-line cyberpunk statusline from the Claude Code JSON payload.
 * @param {StatusData} data
 * @param {import('./palettes').Palette} palette
 * @param {RenderOptions} [options]
 * @returns {string}
 */
function renderStatusline(data, palette, options = {}) {
  const sep = color(' \u2502 ', palette.fg_dim);

  // Project segment: derive name from workspace.project_dir
  const projectDir = data.workspace?.project_dir ?? data.workspace?.current_dir;
  const projectName = projectDir ? path.basename(projectDir) : null;
  const projectSegment = projectName
    ? color(projectName, palette.neon_blue, true)
    : null;

  // Model segment: <Name>
  const modelName = data.model?.display_name ?? data.model?.id ?? 'Claude';
  const modelSegment =
    color('\u27e8', palette.neon_pink, true) +
    color(modelName, palette.neon_cyan, true) +
    color('\u27e9', palette.neon_pink, true);

  // Context window segment
  const usedPct = data.context_window?.used_percentage ?? 0;
  const ctxSegment = contextBar(usedPct, palette);

  // Token count segment
  const inputTokens = data.context_window?.total_input_tokens ?? 0;
  const outputTokens = data.context_window?.total_output_tokens ?? 0;
  const totalTokens = inputTokens + outputTokens;
  const tokenSegment = totalTokens > 0
    ? color(formatTokenCount(totalTokens), palette.neon_yellow)
    : null;

  // Cost segment
  const totalCost = data.cost?.total_cost_usd ?? 0;
  const costSegment = color(`$${totalCost.toFixed(2)}`, palette.neon_purple);

  // Lines added/removed segment (omit when both are zero)
  const linesAdded   = data.cost?.total_lines_added   ?? 0;
  const linesRemoved = data.cost?.total_lines_removed  ?? 0;
  const linesSegment =
    linesAdded === 0 && linesRemoved === 0
      ? null
      : `${color(`+${linesAdded}`, palette.neon_green)} ${color(`-${linesRemoved}`, palette.neon_pink)}`;

  // Vim mode segment (opt-in via --vim-mode flag, placed first)
  let vimModeSegment = null;
  if (options.vimMode && data.vim?.mode) {
    const mode = data.vim.mode.toUpperCase();
    const modeColor =
      mode === 'NORMAL' ? palette.neon_blue :
      mode === 'INSERT' ? palette.neon_green :
      palette.neon_yellow;
    vimModeSegment = color(mode, modeColor, true);
  }

  // Session duration segment (opt-in via --duration flag)
  let durationSegment = null;
  if (options.duration && data.cost?.total_duration_ms != null) {
    const wall = formatDuration(data.cost.total_duration_ms);
    const wallPart = color(wall, palette.neon_cyan);
    const apiMs = data.cost.total_api_duration_ms;
    const apiPart =
      apiMs != null && apiMs > 0
        ? color(` (API: ${formatDuration(apiMs)})`, palette.fg_dim)
        : '';
    durationSegment = wallPart + apiPart;
  }

  // Cache hit ratio segment (opt-in via --cache flag)
  let cacheSegment = null;
  if (options.cache && data.context_window?.current_usage != null) {
    const { cache_read_input_tokens: cacheRead = 0, cache_creation_input_tokens: cacheCreation = 0, input_tokens: inputTok = 0 } =
      data.context_window.current_usage;
    const denominator = cacheRead + cacheCreation + inputTok;
    if (denominator > 0) {
      const ratio = (cacheRead / denominator) * 100;
      const cacheColor =
        ratio >= 70 ? palette.neon_green :
        ratio >= 40 ? palette.neon_yellow :
        palette.neon_orange;
      cacheSegment = color(`\u26a1 ${Math.round(ratio)}%`, cacheColor);
    }
  }

  // Git branch segment (opt-in via --git flag)
  let branchSegment = null;
  if (options.git) {
    const cwd = data.workspace?.current_dir ?? process.cwd();
    const branch = gitBranch(cwd);
    branchSegment = branch ? color(branch, palette.neon_blue) : null;
  }

  // Assemble — filter out null optional segments before joining.
  // vimModeSegment leads; branchSegment, durationSegment, cacheSegment trail.
  const segments = [
    vimModeSegment,
    projectSegment,
    modelSegment,
    ctxSegment,
    tokenSegment,
    costSegment,
    linesSegment,
    branchSegment,
    durationSegment,
    cacheSegment,
  ].filter(Boolean);

  return segments.join(sep);
}

module.exports = { renderStatusline };
