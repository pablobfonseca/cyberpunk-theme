import fs from 'node:fs/promises'
import path from 'node:path'
import { execFile } from 'node:child_process'
import { promisify } from 'node:util'
import { select } from '@inquirer/prompts'
import { fileExists } from '../lib/fs-helpers.js'

const execFileAsync = promisify(execFile)

export const id   = 'neovim'
export const name = 'Neovim'

const PACK_PATH = path.join(
  process.env.HOME,
  '.local', 'share', 'nvim', 'site', 'pack', 'plugins', 'start', 'cyberpunk-theme',
)
const LAZY_PATH = path.join(
  process.env.HOME,
  '.local', 'share', 'nvim', 'lazy', 'cyberpunk-theme',
)

/**
 * Returns true if the cyberpunk-theme directory exists in any known pack path.
 *
 * @returns {Promise<boolean>}
 */
export async function detect() {
  return (await fileExists(PACK_PATH)) || (await fileExists(LAZY_PATH))
}

/**
 * Builds the lazy.nvim plugin spec snippet for the given variant.
 *
 * @param {string} variant
 * @returns {string}
 */
function lazySnippet(variant) {
  return `{
  'pablobfonseca/cyberpunk-theme',
  priority = 1000,
  lazy = false,
  config = function()
    require('cyberpunk').setup({ style = '${variant}' })
    vim.cmd('colorscheme cyberpunk')
  end,
}`
}

/**
 * Builds the packer plugin spec snippet for the given variant.
 *
 * @param {string} variant
 * @returns {string}
 */
function packerSnippet(variant) {
  return `use {
  'pablobfonseca/cyberpunk-theme',
  config = function()
    require('cyberpunk').setup({ style = '${variant}' })
    vim.cmd('colorscheme cyberpunk')
  end,
}`
}

/**
 * Attempts to copy `text` to the system clipboard using execFile (never exec).
 * Silently swallows errors so a missing clipboard tool does not abort install.
 *
 * @param {string} text
 * @returns {Promise<void>}
 */
async function copyToClipboard(text) {
  const [cmd, args] =
    process.platform === 'darwin'
      ? ['pbcopy', []]
      : ['xclip', ['-selection', 'clipboard']]

  try {
    const child = execFile(cmd, args)
    await new Promise((resolve, reject) => {
      child.stdin.write(text)
      child.stdin.end()
      child.on('close', code => (code === 0 ? resolve() : reject(new Error(`exit ${code}`))))
      child.on('error', reject)
    })
  } catch {
    // Clipboard copy failure is non-fatal — snippet was already printed.
  }
}

/**
 * Guides the user through installing the Neovim cyberpunk theme via their
 * preferred plugin manager, or creates a manual symlink into the pack path.
 *
 * @param {string} variant   - 'storm' | 'night' | 'neon'
 * @param {string} repoRoot  - Absolute path to the repository root
 * @param {{ dryRun?: boolean }} [opts]
 * @returns {Promise<{ message: string, postInstallMessage?: string }>}
 */
export async function install(variant, repoRoot, opts = {}) {
  const manager = await select({
    message: 'Which plugin manager?',
    choices: [
      { name: 'lazy.nvim', value: 'lazy' },
      { name: 'packer',    value: 'packer' },
      { name: 'manual (symlink into pack path)', value: 'manual' },
    ],
  })

  if (manager === 'lazy' || manager === 'packer') {
    const snippet = manager === 'lazy' ? lazySnippet(variant) : packerSnippet(variant)
    console.log('\nAdd this to your Neovim config:\n')
    console.log(snippet)
    console.log()
    await copyToClipboard(snippet)
    return { message: 'snippet copied to clipboard' }
  }

  // manual: symlink repoRoot -> PACK_PATH
  if (opts.dryRun) {
    console.log(`[dry-run] Would create symlink: ${repoRoot} -> ${PACK_PATH}`)
    return { message: 'symlinked to pack path' }
  }

  await fs.mkdir(path.dirname(PACK_PATH), { recursive: true })

  // Skip if symlink/directory already exists at target
  if (await fileExists(PACK_PATH)) {
    return { message: 'symlinked to pack path' }
  }

  await fs.symlink(repoRoot, PACK_PATH)
  return { message: 'symlinked to pack path' }
}
