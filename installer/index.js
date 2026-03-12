#!/usr/bin/env node
import { select, checkbox, confirm } from '@inquirer/prompts'
import { printBanner } from './lib/banner.js'
import { printSummary } from './lib/summary.js'
import { dirname, resolve } from 'node:path'
import { fileURLToPath } from 'node:url'
import * as ghostty from './components/ghostty.js'
import * as starship from './components/starship.js'
import * as tmux from './components/tmux.js'
import * as claudeCode from './components/claude-code.js'
import * as neovim from './components/neovim.js'
import * as vscode from './components/vscode.js'
import * as userstyles from './components/userstyles.js'

const __dirname = dirname(fileURLToPath(import.meta.url))
const repoRoot  = resolve(__dirname, '..')
const dryRun    = process.argv.includes('--dry-run')

/**
 * Registered components. Each entry must implement:
 *   {
 *     id:      string,
 *     name:    string,
 *     install: (variant: string, repoRoot: string, opts: { dryRun: boolean }) => Promise<{ message?: string, postInstallMessage?: string }>
 *   }
 *
 * Components are added here as subsequent tasks are completed.
 */
const components = [neovim, tmux, ghostty, starship, vscode, claudeCode, userstyles]

async function main() {
  printBanner()

  if (dryRun) console.log('\n⚡ Dry-run mode — no files will be modified\n')

  // 1. Variant selection
  const variantChoice = await select({
    message: 'Which variant?',
    choices: [
      { name: 'Storm (default — dark blues, full neon)', value: 'storm' },
      { name: 'Night (deeper blacks, muted neon)',       value: 'night' },
      { name: 'Neon (pure black, max saturation)',       value: 'neon'  },
      { name: 'Mix and match (choose per component)',    value: 'mix'   },
    ],
  })

  // 2. Component selection
  if (components.length === 0) {
    console.log('No components registered — nothing to install.')
    process.exit(0)
  }

  const selected = await checkbox({
    message: 'Which components to install?',
    choices: components.map(c => ({
      name:    c.name,
      value:   c.id,
      checked: false,
    })),
  })

  if (selected.length === 0) {
    console.log('Nothing selected — exiting.')
    process.exit(0)
  }

  // 3. Per-component variant when mix-and-match is chosen
  const variants = {}
  for (const id of selected) {
    if (variantChoice === 'mix') {
      variants[id] = await select({
        message: `Variant for ${components.find(c => c.id === id).name}?`,
        choices: [
          { name: 'Storm', value: 'storm' },
          { name: 'Night', value: 'night' },
          { name: 'Neon',  value: 'neon'  },
        ],
      })
    } else {
      variants[id] = variantChoice
    }
  }

  // 4. Confirm before writing anything
  const proceed = await confirm({ message: 'Proceed with installation?' })
  if (!proceed) {
    console.log('Cancelled.')
    process.exit(0)
  }

  // 5. Install each selected component
  const results = []
  for (const id of selected) {
    const comp    = components.find(c => c.id === id)
    const variant = variants[id]

    process.stdout.write(`⚡ Installing ${comp.name}...`)
    try {
      const result = await comp.install(variant, repoRoot, { dryRun })
      console.log(' done')
      results.push({ name: comp.name, variant, status: '✔', ...result })
    } catch (err) {
      console.log(' failed')
      results.push({ name: comp.name, variant, status: '✘', message: err.message })
    }
  }

  // 6. Print installation summary
  printSummary(results)
}

main().catch(err => {
  console.error(err)
  process.exit(1)
})
