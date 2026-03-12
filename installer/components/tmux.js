import path from 'node:path'
import { select } from '@inquirer/prompts'
import { appendIfAbsent } from '../lib/fs-helpers.js'

export const id   = 'tmux'
export const name = 'Tmux'

const TMUX_CONF = path.join(process.env.HOME, '.tmux.conf')

/**
 * Returns true if ~/.tmux.conf already references cyberpunk-theme.
 *
 * @returns {Promise<boolean>}
 */
export async function detect() {
  try {
    const { readFile } = await import('node:fs/promises')
    const content = await readFile(TMUX_CONF, 'utf8')
    return content.includes('cyberpunk-theme')
  } catch (err) {
    if (err.code === 'ENOENT') return false
    throw err
  }
}

/**
 * Appends the cyberpunk theme configuration to ~/.tmux.conf, using either
 * TPM (plugin manager) or a direct manual run invocation.
 *
 * @param {string} variant   - 'storm' | 'night' | 'neon'
 * @param {string} repoRoot  - Absolute path to the repository root
 * @param {{ dryRun?: boolean }} [opts]
 * @returns {Promise<{ message: string, postInstallMessage: string }>}
 */
export async function install(variant, repoRoot, opts = {}) {
  const method = await select({
    message: 'Install method for Tmux?',
    choices: [
      { name: 'TPM (plugin manager)', value: 'tpm'    },
      { name: 'Manual',               value: 'manual' },
    ],
  })

  if (method === 'tpm') {
    await appendIfAbsent(
      TMUX_CONF,
      'pablobfonseca/cyberpunk-theme',
      `\n# Cyberpunk theme\nset -g @cyberpunk_flavor '${variant}'\nset -g @plugin 'pablobfonseca/cyberpunk-theme'\n`,
      opts,
    )
  } else {
    await appendIfAbsent(
      TMUX_CONF,
      'cyberpunk.tmux',
      `\n# Cyberpunk theme\nset -g @cyberpunk_flavor '${variant}'\nrun '${repoRoot}/cyberpunk.tmux'\n`,
      opts,
    )
  }

  return {
    message:            '~/.tmux.conf (appended)',
    postInstallMessage: 'Run "tmux source ~/.tmux.conf" or restart tmux',
  }
}
