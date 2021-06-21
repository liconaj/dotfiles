source $VIMRUNTIME/mswin.vim
behave mswin

let g:light_theme = 1

" VIM PLUG:

call plug#begin(stdpath('data') . '/plugged')

Plug 'tpope/vim-surround'
Plug 'sainnhe/edge'
Plug 'sainnhe/everforest'
Plug 'sainnhe/sonokai'

Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

Plug 'mhinz/vim-startify'
Plug 'preservim/nerdtree'
Plug 'honza/vim-snippets'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'skywind3000/asyncrun.vim'
Plug 'eapache/auto-pairs'
Plug 'ryanoasis/vim-devicons'
Plug 'thaerkh/vim-indentguides'

Plug 'fatih/vim-go'
Plug 'davisdude/vim-love-docs', {'branch': 'build', 'do': 'rm -r after'}
Plug 'sheerun/vim-polyglot'

call plug#end()


" OPTIONS:

let mapleader = ' '
set nocompatible


filetype plugin indent on
syntax on

set guicursor

set autoindent
set smartindent
set tabstop=4
set softtabstop=0
set shiftround
set shiftwidth=4
"set expandtab


set backspace=indent,eol,start
set virtualedit=block,onemore
set hidden
set laststatus=2
set display=lastline

set scrolloff=3
set sidescroll=1
set sidescrolloff=10

set showmode
set showcmd

set incsearch
set hlsearch
set ignorecase
set smartcase
nnoremap <silent> <BS> :nohlsearch<CR>

set ttyfast
set lazyredraw

set splitright
set splitbelow

set cursorbind
set wrapscan
set wrap
set whichwrap+=<,>,h,l,[,]
set report=0

set number
set autochdir
set clipboard=unnamedplus
set formatoptions+=rnlmM

if &shell =~# 'fish$'
	set shell=/bin/bash
endif

set nobackup
set nowritebackup
"set backupdir=$HOME/.vim/files/backup
set backupext=-vimbackup
set backupskip=
"set directory=$HOME/.vim/files/swap//
set updatecount=100
set undofile
"set undodir=$HOME/.vim/files/undo
"set viminfo='100,n$HOME/.vim/files/info/viminfo

set encoding=UTF-8
set fileencodings=ucs-bom,utf-8,default,cp936,big5,latin1
set fileformats=unix,mac,dos

set showtabline=2
set shortmess+=at
set mouse=a
set nospell
set wildmenu
set wildignore=*.so,*.swp,.*pyc,*.pyo,*.exe,*.zip
if has("win32")
	set wildignore+=.git\*,.hg\*,.svn\*,*\desktop.ini
else
	set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
end

if (has('termguicolors'))
	set termguicolors
endif

set autoread
set autowrite

set nuw=6

" Disable autocomment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" CHARACTERS:
" Quit ~ from empty lines
"set fillchars+=eob:\ ,
set fillchars+=vert:│
hi! VertSplit ctermbg=NONE guibg=NONE

" TRAILING WHITESPACES:
"autocmd FileType c,cpp,go,py,lua autocmd BufWritePre <buffer> %s/\s\+$//e
autocmd BufWritePre <buffer> %s/\s\+$//e

" THEME:
let g:everforest_hide_endofbuffer=1

let g:edge_style = "aura"
let g:sonokai_style = "atlantis"

if g:light_theme
	set background=light
	colorscheme edge
	let b:lightline_theme = 'edge'
else
	set background=dark
	colorscheme everforest
	let b:lightline_theme = 'everforest'
endif

" LIGHTLINE:

function! LightlineFilename()
	let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
	let modified = &modified ? ' +' : ''
	return filename . modified
endfunction

let g:lightline = {
			\ 'colorscheme' : b:lightline_theme,
			\ 'active': {
			\   'left': [[ 'mode', 'paste' ], [ 'readonly', 'filename' ]]
			\ },
			\ 'tabline': {
			\   'left': [ ['buffers'] ],
			\   'right': [ ['text'] ]
			\ },
			\ 'component_expand': {
			\   'buffers': 'lightline#bufferline#buffers'
			\ },
			\ 'component_type': {
			\   'buffers': 'tabsel'
			\ },
			\ 'component_function': {
			\   'filename' : 'LightlineFilename',
			\ },
			\ 'component': { 'text': 'BUFFERS' },
			\ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
			\ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
			\ }

"let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#show_number  = 0

" AUTO PAIRS:
let g:AutoPairsUseInsertedCount = 1
let g:AutoPairsSmartQuotes = 1
let g:AutoPairsMapCR = 1
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"'}
let g:AutoPairsOnlyWhitespace = 1
let g:AutoPairsShortcutToggle = '<M-ñ>'
let g:AutoPairsMapBS = 1

" COC:

let g:go_def_mapping_enabled = 0

set updatetime=300
set shortmess+=c
set signcolumn=number

let g:coc_global_extensions = [
			\ 'coc-json',
			\ 'coc-git',
			\ 'coc-go',
			\ 'coc-html',
			\ 'coc-jedi',
			\ 'coc-toml',
			\ 'coc-python',
			\ 'coc-vimlsp',
			\ 'coc-snippets',
			\ 'coc-prettier',
			\ 'coc-lua'
			\ ]

command! -nargs=0 Prettier :CocCommand prettier.formatFile
command! -nargs=0 Format :call CocAction('format')


inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
	inoremap <silent><expr> <c-space> coc#refresh()
else
	inoremap <silent><expr> <c-@> coc#refresh()
endif

if exists('*complete_info')
	inoremap <silent><expr> <cr> complete_info(['selected'])['selected'] != -1 ? "\<C-y>" : "\<C-g>u\<CR>"
else
	inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif


imap <C-l> <Plug>(coc-snippets-expand)

imap <C-j> <Plug>(coc-snippets-expand-jump)
vmap <C-j> <Plug>(coc-snippets-expand)
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)
augroup mygroup
	autocmd!
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac <Plug>(coc-codeaction)

" Apply AutoFix to problem on the current line.
nmap <leader>qf <Plug>(coc-fix-current)

" NERDTREE:

let g:NERDTreeBookmarksFile = '.vim/.bookmarks'

let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''

let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=0
let g:netrw_menu=0

nnoremap <leader>n :NERDTreeToggle<CR>

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

function! NERDTreeToggleInCurDir()
	" If NERDTree is open in the current buffer
	if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
		exe ":NERDTreeClose"
	else
		if (expand("%:t") != '')
			exe ":NERDTreeFind"
		else
			exe ":NERDTreeToggle"
		endif
	endif
endfunction

" nnoremap <leader>nf :NERDTreeFind<cr>
nnoremap <leader>nf :call NERDTreeToggleInCurDir()<cr>


" ASYNCRUN:
nnoremap <silent> <expr> & ':AsyncRun -post=cw ' . input('> ') . '<CR>'
nnoremap <silent> <expr> g& ':AsyncRun -save -post=copen -strip ' . input('> ', 'rg --vimgrep ' . expand('<cword>') . ' %') . '<CR>

" LOVE2D:
autocmd FileType lua nmap <buffer> ,r :AsyncRun love . <CR>
"autocmd FileType lua nmap <buffer> ,r :AsyncRun amulet . <CR>
autocmd BufNewFile,BufRead *.lua setlocal expandtab tabstop=2 shiftwidth=2

" GOLANG:

autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd FileType go nmap <buffer> ,b  :AsyncRun -post=cw go run . <CR>
autocmd FileType go nmap <buffer> ,r  :AsyncRun -post=cw go build . <CR>
autocmd FileType go setlocal expandtab

let g:go_highlight_types=1
let g:go_highlight_extra_types=1
let g:go_highlight_functions=1
let g:go_highlight_function_calls=1
let g:go_highlight_build_constraints=1

let g:go_fmt_command = "goimports"
let g:go_addtags_transform = "camelcase"
let g:go_textobj_include_function_doc = 0

" STARTIFY:
nnoremap ,s :Startify<CR>
let g:startify_custom_header=[]
let g:startify_lists=[
			\ { 'type': 'files', 'header': ['    Recent files']},
			\ ]

" INDENT GUIDES:
let g:indentguides_ignorelist = ['startify']
let g:indentguides_spacechar = ""
let g:indentguides_tabchar = ""
" ┊  │

" SAVE FILE AS SUDO:
if !has('win32')
	command! SuW w !sudo tee % > /dev/null
endif

" SELECT ALL:
map <C-a> <esc>gg0vG$<CR>

" COPY PASTE:
nnoremap <M-p> "+P=']
nnoremap <M-y> "+y
nnoremap <M-d> "+d
inoremap <M-p> <C-o>"+P<C-o>=']
inoremap <M-y> <C-o>"+y
inoremap <M-d> <C-o>"+d

" INSERT COMMAND:
inoremap <M-x> <esc>:
nnoremap <M-x> :

" HOME MAP:
nnoremap <M-m> ^
inoremap <M-m> <C-o>^
vnoremap <M-m> ^

" BUFFER NAVIGATION:

hi! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg

nnoremap <leader>l :bnext<CR>
nnoremap <leader>h :bprevious<CR>
nnoremap <leader>q :bdelete<CR>

nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)

nmap <Leader>c1 <Plug>lightline#bufferline#delete(1)
nmap <Leader>c2 <Plug>lightline#bufferline#delete(2)
nmap <Leader>c3 <Plug>lightline#bufferline#delete(3)
nmap <Leader>c4 <Plug>lightline#bufferline#delete(4)
nmap <Leader>c5 <Plug>lightline#bufferline#delete(5)
nmap <Leader>c6 <Plug>lightline#bufferline#delete(6)
nmap <Leader>c7 <Plug>lightline#bufferline#delete(7)
nmap <Leader>c8 <Plug>lightline#bufferline#delete(8)
nmap <Leader>c9 <Plug>lightline#bufferline#delete(9)
nmap <Leader>c0 <Plug>lightline#bufferline#delete(10)

" TABS TO SPACES:
" :set expandtab
" :%retab!
"
" SPACES TO TABS:
" :set tabstop=4
" :set noexpandtab
" :%retab!
"
" REINDENT:
" Use = operator in visual mode
" gg=G
" C-a =

