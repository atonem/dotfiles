" Enter to insert blank lines

" Switch panes without C-W lead
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Tab commands
nnoremap tn :tabnew<CR>
" nnoremap tc :tabclose<CR>
nnoremap H :tabprev<CR>
nnoremap L :tabnext<CR>

" Open new line below and above current line
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>

" Make Y behave like other capitals
nnoremap Y y$

" qq to record, Q to replay
nnoremap Q @q

" use ctrl+hjkl in insert mode
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>

" TODO: Add more i/c mappings for w, W, b, B, etc.

" ----------------------------------------------------------------------------
" Moving lines
" ----------------------------------------------------------------------------
" nnoremap <silent> ? :move-2<cr>
" nnoremap <silent> ? :move+<cr>
" nnoremap <silent> <C-h> <<
" nnoremap <silent> <C-l> >>
" xnoremap <silent> <C-k> :move-2<cr>gv
" xnoremap <silent> <C-j> :move'>+<cr>gv
" xnoremap <silent> <C-h> <gv
" xnoremap <silent> <C-l> >gv
" xnoremap < <gv
" xnoremap > >gv
