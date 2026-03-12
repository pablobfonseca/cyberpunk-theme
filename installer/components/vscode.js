import fs from 'node:fs/promises'
import path from 'node:path'
import { fileExists } from '../lib/fs-helpers.js'

export const id   = 'vscode'
export const name = 'VSCode'

const EXTENSIONS_DIR  = path.join(process.env.HOME, '.vscode', 'extensions')
const EXTENSION_LINK  = path.join(EXTENSIONS_DIR, 'cyberpunk-theme')

/**
 * Returns true if the cyberpunk-theme extension symlink/directory already exists.
 *
 * @returns {Promise<boolean>}
 */
export async function detect() {
  return fileExists(EXTENSION_LINK)
}

/**
 * Creates a symlink from the repo's VSCode extras into the user's VSCode
 * extensions directory, making the theme available immediately without a
 * Marketplace install.
 *
 * @param {string} variant   - 'storm' | 'night' | 'neon'
 * @param {string} repoRoot  - Absolute path to the repository root
 * @param {{ dryRun?: boolean }} [opts]
 * @returns {Promise<{ message: string, postInstallMessage: string }>}
 */
export async function install(variant, repoRoot, opts = {}) {
  const src           = path.join(repoRoot, 'extras', 'vscode')
  const variantLabel  = variant.charAt(0).toUpperCase() + variant.slice(1)

  if (opts.dryRun) {
    console.log(`[dry-run] Would create symlink: ${src} -> ${EXTENSION_LINK}`)
    return {
      message:            EXTENSION_LINK,
      postInstallMessage: `Open VSCode → Cmd+K Cmd+T → select "Cyberpunk ${variantLabel}"`,
    }
  }

  await fs.mkdir(EXTENSIONS_DIR, { recursive: true })

  if (await fileExists(EXTENSION_LINK)) {
    return {
      message:            EXTENSION_LINK,
      postInstallMessage: `Open VSCode → Cmd+K Cmd+T → select "Cyberpunk ${variantLabel}"`,
    }
  }

  await fs.symlink(src, EXTENSION_LINK)

  return {
    message:            EXTENSION_LINK,
    postInstallMessage: `Open VSCode → Cmd+K Cmd+T → select "Cyberpunk ${variantLabel}"`,
  }
}
