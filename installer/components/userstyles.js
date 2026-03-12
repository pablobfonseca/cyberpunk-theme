export const id   = 'userstyles'
export const name = 'Userstyles (ChatGPT & Claude)'

const RAW_BASE =
  'https://raw.githubusercontent.com/pablobfonseca/cyberpunk-theme/main/extras/userstyles'

/**
 * Browser extension state cannot be detected from the filesystem.
 *
 * @returns {Promise<boolean>}
 */
export async function detect() {
  return false
}

/**
 * Builds raw-GitHub URLs for both userstyle files and prints installation
 * instructions. No filesystem operations are performed.
 *
 * @param {string} variant   - 'storm' | 'night' | 'neon'
 * @param {string} _repoRoot - Unused; kept for interface consistency
 * @param {object} [_opts]   - Unused; kept for interface consistency
 * @returns {Promise<{ message: string, postInstallMessage: string }>}
 */
export async function install(variant, _repoRoot, _opts = {}) {
  const chatgptUrl = `${RAW_BASE}/chatgpt/cyberpunk-${variant}.user.css`
  const claudeUrl  = `${RAW_BASE}/claude/cyberpunk-${variant}.user.css`

  const postInstallMessage = [
    'Install the Stylus browser extension first:',
    '  https://add0n.com/stylus.html',
    '',
    'Then click each URL to install the userstyle:',
    `  ChatGPT : ${chatgptUrl}`,
    `  Claude  : ${claudeUrl}`,
  ].join('\n')

  return {
    message: 'see manual steps below',
    postInstallMessage,
  }
}
