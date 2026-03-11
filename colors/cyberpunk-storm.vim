" Cyberpunk Theme - Storm variant
" Deep dark backgrounds, classic neon accents

if has('nvim') && has('lua')
  lua require('cyberpunk').setup({ style = 'storm' }); require('cyberpunk').load()
  finish
endif

" Fallback: load the default theme for older Vim
source <sfile>:h/cyberpunk.vim
