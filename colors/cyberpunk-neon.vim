" Cyberpunk Theme - Neon variant
" Pure black backgrounds with maximum saturation neon accents

if has('nvim') && has('lua')
  lua require('cyberpunk').setup({ style = 'neon' }); require('cyberpunk').load()
  finish
endif

" Fallback: load the default theme for older Vim
source <sfile>:h/cyberpunk.vim
