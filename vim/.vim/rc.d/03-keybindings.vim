" Enter to insert blank lines

" Switch panes without C-W lead
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap ; :

" Tab commands
nnoremap tn :tabnew<CR>
nnoremap tc :tabclose<CR>
nnoremap H :tabprev<CR>
nnoremap L :tabnext<CR>

" Map alt+n to go to specific tab
nnoremap ¡ 1gt
nnoremap ™ 2gt
nnoremap £ 3gt
nnoremap ¢ 4gt
nnoremap ∞ 5gt
nnoremap § 6gt
nnoremap ¶ 7gt
nnoremap • 8gt
nnoremap ª 9gt
nnoremap º 0gt

" Open new line below and above current line
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>

" Make Y behave like other capitals
nnoremap Y y$

" qq to record, Q to replay
nnoremap Q @q

" ----------------------------------------------------------------------------
" Moving lines
" ----------------------------------------------------------------------------
" nnoremap <silent> ¬ :move-2<cr>
" nnoremap <silent> ∆ :move+<cr>
" nnoremap <silent> <C-h> <<
" nnoremap <silent> <C-l> >>
" xnoremap <silent> <C-k> :move-2<cr>gv
" xnoremap <silent> <C-j> :move'>+<cr>gv
" xnoremap <silent> <C-h> <gv
" xnoremap <silent> <C-l> >gv
" xnoremap < <gv
" xnoremap > >gv
