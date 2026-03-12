// ANSI true-color palette matching the cyberpunk theme
const GREEN  = '\x1b[38;2;0;255;65m';
const RED    = '\x1b[38;2;255;50;50m';
const YELLOW = '\x1b[38;2;255;215;0m';
const CYAN   = '\x1b[38;2;0;255;255m';
const DIM    = '\x1b[2m';
const RESET  = '\x1b[0m';

const TICK  = `${GREEN}✔${RESET}`;
const CROSS = `${RED}✘${RESET}`;
const WARN  = `${YELLOW}⚠${RESET}`;

/**
 * Pad `str` to exactly `width` characters (truncates if longer).
 * @param {string} str
 * @param {number} width
 * @returns {string}
 */
function pad(str, width) {
  // Strip ANSI escape codes for length calculation
  const visible = str.replace(/\x1b\[[0-9;]*m/g, '');
  const diff = width - visible.length;
  return diff > 0 ? str + ' '.repeat(diff) : str;
}

/**
 * Resolve the display icon for a result row.
 * @param {{ status: string, postInstallMessage?: string }} result
 * @returns {string} ANSI-colored icon
 */
function resolveIcon(result) {
  if (result.status === '✔' && result.postInstallMessage) return WARN;
  if (result.status === '✔') return TICK;
  return CROSS;
}

/**
 * Print a formatted summary table of installation results.
 *
 * Each result object should conform to:
 *   { name: string, variant: string, status: '✔'|'✘', message?: string, postInstallMessage?: string }
 *
 * @param {Array<{ name: string, variant: string, status: string, message?: string, postInstallMessage?: string }>} results
 */
export function printSummary(results) {
  if (results.length === 0) return;

  const COL = {
    name:    14,
    variant: 8,
    status:  7,
    details: 32,
  };

  const innerWidth = COL.name + COL.variant + COL.status + COL.details + 3; // 3 separating spaces
  const border     = '─'.repeat(innerWidth + 2); // +2 for side padding

  const header = (
    pad('Component', COL.name) +
    ' ' + pad('Variant', COL.variant) +
    ' ' + pad('Status', COL.status) +
    ' ' + 'Details'
  );

  console.log(`\n${CYAN}┌${border}┐${RESET}`);
  console.log(`${CYAN}│${RESET} ${DIM}${header}${RESET} ${CYAN}│${RESET}`);
  console.log(`${CYAN}├${border}┤${RESET}`);

  const manualSteps = [];

  for (const result of results) {
    const icon    = resolveIcon(result);
    const details = result.message ?? result.postInstallMessage ?? '';

    const row = (
      pad(result.name, COL.name) +
      ' ' + pad(result.variant, COL.variant) +
      ' ' + pad(icon, COL.status + (icon.length - 1)) + // compensate for ANSI escape length
      ' ' + details.slice(0, COL.details)
    );

    console.log(`${CYAN}│${RESET} ${row} ${CYAN}│${RESET}`);

    if (result.postInstallMessage) {
      manualSteps.push({ name: result.name, message: result.postInstallMessage });
    }
  }

  console.log(`${CYAN}└${border}┘${RESET}`);

  if (manualSteps.length > 0) {
    console.log(`\n${YELLOW}Manual steps:${RESET}`);
    for (const { name, message } of manualSteps) {
      console.log(`  ${DIM}${name}:${RESET} ${message}`);
    }
  }

  console.log('');
}
