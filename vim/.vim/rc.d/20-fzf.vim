nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>da :Lines<CR>
nnoremap <silent> <leader>dd :BLines<CR>
nnoremap <silent> <leader>db :Buffers<CR>
" The following binding collides with gitutter, should be looked at
nnoremap <silent> <leader>dh :History<CR>
nnoremap <silent> <leader>dg :GFiles?<CR>
nnoremap <silent> <leader>dc :BCommits<CR>
nnoremap <silent> <leader>t :BTags<CR>
nnoremap <silent> <leader>T :Tags<CR>
nnoremap <silent> <leader>m :Marks<CR>
nnoremap <silent> <leader>w :Windows<CR>
nnoremap <silent> <leader>C :commits<CR>
" nnoremap <silent> <leader>s :Snippets<CR>

" Open files
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" Try to jump to buffers
let g:fzf_buffers_jump = 1

augroup fzf
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noruler nonumber norelativenumber
    \| autocmd BufLeave <buffer> set laststatus=2 ruler number relativenumber
augroup END

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Use fuzzy completion relative filepaths across directory
imap <expr> <c-x><c-f> fzf#vim#complete#path('git ls-files $(git rev-parse --show-toplevel)')

" Better command history with q:
command! CmdHist call fzf#vim#command_history({'right': '40'})
nnoremap q: :CmdHist<CR>

" Better search history
command! QHist call fzf#vim#search_history({'right': '40'})
nnoremap q/ :QHist<CR>
