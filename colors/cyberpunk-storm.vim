" Cyberpunk Theme - Storm variant
" Deep dark backgrounds, classic neon accents

if has('nvim') && has('lua')
  lua local c = require('cyberpunk'); c.config.style = 'storm'; c.load()
  finish
endif

" Fallback: load the default theme for older Vim
source <sfile>:h/cyberpunk.vim
