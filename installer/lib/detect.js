/**
 * Runs each component's detect() in parallel and returns a Map of results.
 *
 * A failed detect() is treated as not installed — one broken component must
 * never prevent others from being queried.
 *
 * @param {Array<{ id: string, detect: () => Promise<boolean|*> }>} components
 * @returns {Promise<Map<string, { installed: boolean }>>}
 */
export async function detectAll(components) {
  const entries = await Promise.all(
    components.map(async ({ id, detect }) => {
      try {
        const result = await detect()
        return [id, { installed: Boolean(result) }]
      } catch {
        return [id, { installed: false }]
      }
    }),
  )

  return new Map(entries)
}
