" Cyberpunk Theme Plugin Registration
" Ensures proper loading and registration in Neovim

if exists('g:loaded_cyberpunk')
  finish
endif
let g:loaded_cyberpunk = 1

" Register the colorscheme
if !exists('g:cyberpunk_loaded')
  let g:cyberpunk_loaded = 1
  
  " Define commands for theme management
  command! CyberpunkReload lua require('cyberpunk').load()
  command! CyberpunkToggleTransparent lua require('cyberpunk').toggle_transparent()
  
  " Auto-load if specified as colorscheme
  augroup CyberpunkTheme
    autocmd!
    autocmd ColorScheme cyberpunk lua require('cyberpunk').load()
  augroup END
endif

" Provide backward compatibility
if has('vim')
  " Basic vim support (limited functionality)
  echo "Cyberpunk theme: Use Neovim for full experience!"
endif