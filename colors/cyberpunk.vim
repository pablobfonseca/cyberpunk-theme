" Cyberpunk Theme for Neovim
" A neon-soaked cyberpunk theme with electric aesthetics
" Maintainer: Shikamaru <pablobfonseca@gmail.com>

if has('nvim') && has('lua')
  lua require('cyberpunk').load()
  finish
endif

" Fallback for older Vim versions (basic color definitions)
hi clear
if exists('syntax_on')
  syntax reset
endif

set background=dark
let g:colors_name = 'cyberpunk'

let s:bg = '#0a0e14'
let s:fg = '#e0e6f0'
let s:neon_pink = '#ff007f'
let s:neon_cyan = '#00ffff'
let s:neon_green = '#00ff41'
let s:neon_purple = '#bf00ff'
let s:neon_orange = '#ff8800'
let s:comment = '#6a7b9a'

exe 'hi Normal guifg=' . s:fg . ' guibg=' . s:bg
exe 'hi Comment guifg=' . s:comment . ' gui=italic'
exe 'hi Constant guifg=' . s:neon_pink
exe 'hi String guifg=' . s:neon_green
exe 'hi Function guifg=' . s:neon_cyan . ' gui=bold'
exe 'hi Keyword guifg=' . s:neon_pink . ' gui=bold'
exe 'hi Type guifg=' . s:neon_purple
exe 'hi Operator guifg=' . s:neon_orange
exe 'hi Number guifg=' . s:neon_purple
exe 'hi Boolean guifg=' . s:neon_purple

exe 'hi LineNr guifg=#3b4458'
exe 'hi CursorLineNr guifg=' . s:neon_cyan . ' gui=bold'
exe 'hi Visual guibg=#2a1f3d'
exe 'hi Search guifg=' . s:bg . ' guibg=' . s:neon_orange
exe 'hi StatusLine guifg=' . s:fg . ' guibg=#1a1f25'

exe 'hi ErrorMsg guifg=' . s:neon_pink
exe 'hi WarningMsg guifg=' . s:neon_orange
