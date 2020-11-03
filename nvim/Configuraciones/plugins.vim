" ==================================================
"               Begin call plugins
" ==================================================

call plug#begin('~/.local/share/nvim/plugged')
" ==================================================
"                       Themes
" ==================================================
Plug 'kuntau/ayu-vim'
Plug 'sainnhe/sonokai'
Plug 'kaicataldo/material.vim'
Plug 'phanviet/vim-monokai-pro'

" ==================================================
"                   Autocomplete
" ==================================================
" Require `pip3 install --user --upgrade pynvim`
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neco-syntax'               " Fuente general de auto completado
Plug 'Shougo/neco-vim'                  " Vim commanda
Plug 'deoplete-plugins/deoplete-jedi'   " Python
Plug 'Shougo/deoplete-zsh'            " Zsh
Plug 'wokalski/autocomplete-flow'         " JavaScript

" ==================================================
"                       Airlane
" ==================================================
Plug 'vim-airline/vim-airline'

" ==================================================
"                   Syntax support
" ==================================================
Plug 'sheerun/vim-polyglot'

" ==================================================
"                   Indentline guides
" ==================================================
Plug 'Yggdroot/indentLine'

" ==================================================
"                       Nerdtree
" ==================================================
Plug 'preservim/nerdtree'

" ==================================================
"                       Snippets
" ==================================================
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

" ==================================================
"               Begin call plugins
" ==================================================
call plug#end()
" ==================================================
