import fs from 'node:fs/promises'
import path from 'node:path'
import { fileExists } from '../lib/fs-helpers.js'

export const id   = 'ghostty'
export const name = 'Ghostty'

const THEMES_DIR  = path.join(process.env.HOME, '.config', 'ghostty', 'themes')
const THEME_FILES = ['Cyberpunk Storm', 'Cyberpunk Night', 'Cyberpunk Neon']

/**
 * Returns true if the Cyberpunk Storm theme is already installed.
 *
 * @returns {Promise<boolean>}
 */
export async function detect() {
  return fileExists(path.join(THEMES_DIR, 'Cyberpunk Storm'))
}

/**
 * Copies all three Ghostty theme files into ~/.config/ghostty/themes/.
 *
 * @param {string} variant   - 'storm' | 'night' | 'neon'
 * @param {string} repoRoot  - Absolute path to the repository root
 * @param {{ dryRun?: boolean }} [opts]
 * @returns {Promise<{ message: string, postInstallMessage: string }>}
 */
export async function install(variant, repoRoot, opts = {}) {
  const srcDir          = path.join(repoRoot, 'extras', 'ghostty')
  const variantLabel    = variant.charAt(0).toUpperCase() + variant.slice(1)

  if (!opts.dryRun) {
    await fs.mkdir(THEMES_DIR, { recursive: true })
  } else {
    console.log(`[dry-run] Would create directory: ${THEMES_DIR}`)
  }

  for (const file of THEME_FILES) {
    const src  = path.join(srcDir, file)
    const dest = path.join(THEMES_DIR, file)

    if (opts.dryRun) {
      console.log(`[dry-run] Would copy: ${src} -> ${dest}`)
    } else {
      await fs.copyFile(src, dest)
    }
  }

  return {
    message:            THEMES_DIR,
    postInstallMessage: `Set \`theme = Cyberpunk ${variantLabel}\` in ~/.config/ghostty/config`,
  }
}
