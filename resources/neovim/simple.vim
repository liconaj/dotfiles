source $VIMRUNTIME/mswin.vim
behave mswin

call plug#begin(stdpath('data') . '/plugged')
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'eapache/auto-pairs'
Plug 'sheerun/vim-polyglot'
call plug#end()

" OPTIONS:

let mapleader = ' '
set nocompatible

filetype plugin indent on
syntax on

set autoindent
set smartindent
set tabstop=4
set softtabstop=0
set shiftround
set shiftwidth=4

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
set clipboard+=unnamedplus
set formatoptions+=rnlmM

if &shell =~# 'fish$'
	set shell=/bin/bash
endif

set nobackup
set nowritebackup
set backupext=-vimbackup
set backupskip=
set updatecount=100
set undofile

set encoding=UTF-8
set fileencodings=ucs-bom,utf-8,default,cp936,big5,latin1
set fileformats=unix,mac,dos

set shortmess+=at
set mouse=a
set nospell
set wildmenu
set wildignore=*.so,*.swp,.*pyc,*.pyo,*.exe,*.zip
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

if (has('termguicolors'))
	set termguicolors
endif

set autoread
set autowrite

set nuw=6

" Disable autocomment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

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

nnoremap <leader>l :bnext<CR>
nnoremap <leader>h :bprevious<CR>
nnoremap <leader>q :bdelete<CR>


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

