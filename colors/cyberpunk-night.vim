" Cyberpunk Theme - Night variant
" Deeper/darker backgrounds with muted neon accents

if has('nvim') && has('lua')
  lua require('cyberpunk').setup({ style = 'night' }); require('cyberpunk').load()
  finish
endif

" Fallback: load the default theme for older Vim
source <sfile>:h/cyberpunk.vim
