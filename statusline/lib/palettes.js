/**
 * Cyberpunk color palettes — three style variants.
 * Colors sourced from lua/cyberpunk/palette.lua in the parent theme.
 *
 * Each palette exposes only the tokens used by the statusline renderer.
 * fg_dim is fg_gutter from the Neovim palette (used for separators).
 */

/** @typedef {{ neon_pink: string, neon_cyan: string, neon_green: string, neon_purple: string, neon_orange: string, neon_blue: string, neon_yellow: string, fg_dim: string }} Palette */

/** @type {Palette} */
const storm = {
  neon_pink:   '#ff007f',
  neon_cyan:   '#00ffff',
  neon_green:  '#00ff41',
  neon_purple: '#bf00ff',
  neon_orange: '#ff8800',
  neon_blue:   '#0080ff',
  neon_yellow: '#ffff00',
  fg_dim:      '#3b4458',
};

/** @type {Palette} */
const night = {
  neon_pink:   '#cc0066',
  neon_cyan:   '#00cccc',
  neon_green:  '#00cc33',
  neon_purple: '#9900cc',
  neon_orange: '#cc6e00',
  neon_blue:   '#0066cc',
  neon_yellow: '#cccc00',
  fg_dim:      '#2d3850',
};

/** @type {Palette} */
const neon = {
  neon_pink:   '#ff0099',
  neon_cyan:   '#00ffff',
  neon_green:  '#00ff00',
  neon_purple: '#dd00ff',
  neon_orange: '#ff6600',
  neon_blue:   '#0099ff',
  neon_yellow: '#ffff00',
  fg_dim:      '#303850',
};

/** @type {Record<string, Palette>} */
const palettes = { storm, night, neon };

/**
 * Return the palette for a given style name, defaulting to storm.
 * @param {string} style
 * @returns {Palette}
 */
function getPalette(style) {
  return palettes[style] ?? storm;
}

module.exports = { getPalette };
