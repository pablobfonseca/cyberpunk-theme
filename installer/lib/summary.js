const GREEN  = '\x1b[38;2;0;255;65m'
const RED    = '\x1b[38;2;255;50;50m'
const YELLOW = '\x1b[38;2;255;215;0m'
const CYAN   = '\x1b[38;2;0;255;255m'
const DIM    = '\x1b[2m'
const RESET  = '\x1b[0m'

/**
 * Print a formatted summary of installation results.
 *
 * @param {Array<{ name: string, variant: string, status: string, message?: string, postInstallMessage?: string }>} results
 */
export function printSummary(results) {
  if (results.length === 0) return

  // Compute column widths from actual data
  const nameW    = Math.max(9, ...results.map(r => r.name.length))
  const variantW = Math.max(7, ...results.map(r => r.variant.length))

  const divider = `${DIM}${'─'.repeat(nameW + variantW + 20)}${RESET}`

  console.log(`\n${divider}`)
  console.log(
    `${DIM}${'Component'.padEnd(nameW)}  ${'Variant'.padEnd(variantW)}  ${''}  Details${RESET}`,
  )
  console.log(divider)

  const manualSteps = []

  for (const result of results) {
    const icon    = result.status === '✔' ? `${GREEN}✔${RESET}` : `${RED}✘${RESET}`
    const details = result.message ?? ''

    console.log(
      `${CYAN}${result.name.padEnd(nameW)}${RESET}  ` +
      `${result.variant.padEnd(variantW)}  ` +
      `${icon}  ` +
      `${DIM}${details}${RESET}`,
    )

    if (result.postInstallMessage) {
      manualSteps.push({ name: result.name, message: result.postInstallMessage })
    }
  }

  console.log(divider)

  if (manualSteps.length > 0) {
    console.log(`\n${YELLOW}Manual steps:${RESET}`)
    for (const { name, message } of manualSteps) {
      console.log(`  ${CYAN}${name}:${RESET} ${message}`)
    }
  }

  console.log('')
}
