nnoremap <leader>s :w<CR>
nnoremap <leader>e :tabnew $MYVIMRC<CR>  
nnoremap <leader>h :tabnew ~/.config/nvim/nvim-tutorial.md<CR>

" Seleccionar texto
inoremap <S-Left> <C-o>vh
nnoremap <S-Left> vh
inoremap <S-Right> <C-o>vl
nnoremap <S-Right> vl
inoremap <S-Up> <C-o>vk
nnoremap <S-Up> vk
inoremap <S-Down> <C-o>vj
nnoremap <S-Down> vj
inoremap <S-End> <C-o>v$
nnoremap <S-End> v$
inoremap <S-Home> <C-o>v0
nnoremap <S-Home> v0

" Pestañas
nnoremap <C-Up> :e %:p:h
inoremap <C-Up> <C-o>:e %:p:h
nnoremap <C-Down> :q<CR>
inoremap <C-Down> <C-o>:q<CR>

" Moverse al buffer siguiente con <líder> + l
nnoremap <leader>l :bnext<CR>

" Moverse al buffer anterior con <líder> + j
nnoremap <leader>j :bprevious<CR>

" Cerrar el buffer actual con <líder> + q
nnoremap <leader>q :bdelete<CR>

" NERDtree
nnoremap <leader>b :NERDTreeToggle<CR>

" Tabs
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Desplazar al primer caracter no espaciado
nnoremap <Home> ^
inoremap <Home> <C-o>^
vnoremap <Home> ^

" Terminal
map <F2> :let $VIM_DIR=expand('%:p:h')<CR>:sp<CR><C-w>j :terminal<CR>:set norelativenumber<CR>cd $VIM_DIR<CR>
tnoremap <ESC> <C-\><C-n>
tnoremap kj <C-\><C-n>:bd!<CR>
tnoremap <C-x> <C-\><C-n><C-w>k

" Ejecutar archivos

nnoremap <F4> <ESC>:w<CR>:!gnome-terminal -- zsh -c "'%:p';echo;echo 'Press Enter to exit...';read"<CR>
inoremap <F4> <ESC>:w<CR>:!gnome-terminal -- zsh -c "'%:p';echo;echo 'Press Enter to exit...';read"<CR>

nnoremap <F5> <ESC>:w<CR>:!gnome-terminal -- zsh -c "python -u '%:p';echo;echo 'Press Enter to exit...';read"<CR>
inoremap <F5> <ESC>:w<CR>:!gnome-terminal -- zsh -c "python -u '%:p';echo;echo 'Press Enter to exit...';read"<CR>

nnoremap <F6> <ESC>:w<CR>:!gnome-terminal -- zsh -c "node '%:p';echo;echo 'Press Enter to exit...';read"<CR>
inoremap <F6> <ESC>:w<CR>:!gnome-terminal -- zsh -c "node -u '%:p';echo;echo 'Press Enter to exit...';read"<CR>

nnoremap <F7> <ESC>:w<CR>:!fbc '%:p' && gnome-terminal -- zsh -c "'./%:r';echo;echo 'Press Enter to exit...';read"<CR>
inoremap <F7> <ESC>:w<CR>:!fbc '%:p' && gnome-terminal -- zsh -c "'./%:r';echo;echo 'Press Enter to exit...';read"<CR>
nnoremap <F31> <ESC>:w<CR>:!fbc '%:p'<CR>
inoremap <F31> <ESC>:w<CR>:!fbc '%:p'<CR>

