import path from 'node:path'
import { execFile } from 'node:child_process'
import { promisify } from 'node:util'
import { patchJson, fileExists } from '../lib/fs-helpers.js'

const execFileAsync = promisify(execFile)

export const id   = 'claude-code'
export const name = 'Claude Code Statusline'

const SETTINGS_FILE = path.join(process.env.HOME, '.claude', 'settings.json')

/**
 * Returns true if ~/.claude/settings.json already contains a `statusLine` key.
 *
 * @returns {Promise<boolean>}
 */
export async function detect() {
  if (!(await fileExists(SETTINGS_FILE))) return false

  try {
    const { readFile } = await import('node:fs/promises')
    const raw  = await readFile(SETTINGS_FILE, 'utf8')
    const data = JSON.parse(raw)
    return 'statusLine' in data
  } catch {
    return false
  }
}

/**
 * Installs the Claude Code cyberpunk powerline statusline.
 * Runs `npm install -g` for the package, then patches ~/.claude/settings.json.
 *
 * @param {string} variant   - 'storm' | 'night' | 'neon'
 * @param {string} repoRoot  - Absolute path to the repository root (unused but kept for interface consistency)
 * @param {{ dryRun?: boolean }} [opts]
 * @returns {Promise<{ message: string }>}
 */
export async function install(variant, _repoRoot, opts = {}) {
  const pkg = '@pablobfonseca/claude-cyberpunk-powerline'

  if (!opts.dryRun) {
    await execFileAsync('npm', ['install', '-g', pkg])
  } else {
    console.log(`[dry-run] Would run: npm install -g ${pkg}`)
  }

  await patchJson(
    SETTINGS_FILE,
    'statusLine',
    {
      type:    'command',
      command: `npx -y ${pkg} --style=${variant}`,
    },
    opts,
  )

  return { message: SETTINGS_FILE }
}
