" Cyberpunk Theme - Night variant
" Deeper/darker backgrounds with muted neon accents

if has('nvim') && has('lua')
  lua local c = require('cyberpunk'); c.config.style = 'night'; c.load()
  finish
endif

" Fallback: load the default theme for older Vim
source <sfile>:h/cyberpunk.vim
