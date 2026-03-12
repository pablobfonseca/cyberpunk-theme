import fs from 'node:fs/promises'
import path from 'node:path'
import { backupAndCopy, fileExists } from '../lib/fs-helpers.js'

export const id   = 'starship'
export const name = 'Starship'

const DEST = path.join(process.env.HOME, '.config', 'starship.toml')

/**
 * Returns true if ~/.config/starship.toml already exists.
 *
 * @returns {Promise<boolean>}
 */
export async function detect() {
  return fileExists(DEST)
}

/**
 * Installs the Starship cyberpunk config, patching the palette line to match
 * the chosen variant. Backs up any pre-existing starship.toml.
 *
 * @param {string} variant   - 'storm' | 'night' | 'neon'
 * @param {string} repoRoot  - Absolute path to the repository root
 * @param {{ dryRun?: boolean }} [opts]
 * @returns {Promise<{ message: string, postInstallMessage?: string }>}
 */
export async function install(variant, repoRoot, opts = {}) {
  const src        = path.join(repoRoot, 'extras', 'starship', 'cyberpunk-storm.toml')
  const hadExisting = await fileExists(DEST)

  await backupAndCopy(src, DEST, opts)

  if (!opts.dryRun) {
    const content = await fs.readFile(DEST, 'utf8')
    const patched = content.replace(
      'palette = "cyberpunk_storm"',
      `palette = "cyberpunk_${variant}"`,
    )
    await fs.writeFile(DEST, patched, 'utf8')
  } else {
    console.log(`[dry-run] Would patch palette line: cyberpunk_storm -> cyberpunk_${variant}`)
  }

  return {
    message:            DEST,
    ...(hadExisting && {
      postInstallMessage: 'Previous config backed up to ~/.config/starship.toml.bak',
    }),
  }
}
