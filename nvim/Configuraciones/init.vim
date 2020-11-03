" ==================================================
"               Inicio
" ==================================================
" Esto tiene que estar antes de la llamada al
" archivo de los atajos
let mapleader=' '
let g:polyglot_disabled = ['markdown']
" ==================================================
"               Load external files
" ==================================================
source ~/.config/nvim/plugins.vim
source ~/.config/nvim/shortcuts.vim     " shortcuts
source ~/.config/nvim/themes.vim        " config themes

" ==================================================
"           General configuration
" ==================================================
set relativenumber
set mouse=a            " Soporte para el puntero
" Tabs e indentation
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set autoindent
set smartindent
set clipboard+=unnamedplus      " Clipboard

" ==================================================
"               Variables
" ==================================================
let g:indentLine_char = '┊'
let g:airline_theme = 'sonokai'
let g:airline_extensions = []
colorscheme sonokai


" ===============================================
"          Snippets and autocompletion
" ===============================================

let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#enable_completed_snippet = 1
let g:deoplete#enable_at_startup = 1
let g:neosnippet#snippets_directory='~/.config/nvim/snippets'
" let g:neosnippet#disable_runtime_snippets " Disable defaults snippets

" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" Disable map arrows
inoremap <expr><Up>     pumvisible() ? "\<C-e>\<Up>"    : "\<Up>"
inoremap <expr><Down>   pumvisible() ? "\<C-e>\<Down>"  : "\<Down>"

" Map TAB to move
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Cerrar automaticamente la ventana de vista previa (donde se muestra documentación, si existe)
augroup deopleteCompleteDoneAu
  autocmd!
  autocmd CompleteDone * silent! pclose!
augroup END

