// ANSI true-color escape sequences for the cyberpunk neon palette
const CYAN  = '\x1b[38;2;0;255;255m';
const PINK  = '\x1b[38;2;255;0;127m';
const GREEN = '\x1b[38;2;0;255;65m';
const DIM   = '\x1b[2m';
const RESET = '\x1b[0m';

const banner = [
  `${CYAN} ╔═══════════════════════════════════════════════╗${RESET}`,
  `${PINK} ║  ${CYAN}⚡${PINK} CYBERPUNK THEME INSTALLER ${CYAN}⚡${PINK}             ║${RESET}`,
  `${PINK} ║  ${GREEN}Neon dreams for your dev environment${PINK}         ║${RESET}`,
  `${PINK} ║  ${DIM}${CYAN}vim · tmux · starship · claude · vscode${RESET}${PINK}      ║${RESET}`,
  `${CYAN} ╚═══════════════════════════════════════════════╝${RESET}`,
].join('\n');

/** Print the cyberpunk installer banner to stdout. */
export function printBanner() {
  console.log(banner);
}
