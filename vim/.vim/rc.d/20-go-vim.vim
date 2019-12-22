let g:go_list_type = 'quickfix'

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

let g:go_fmt_command = 'goimports'
let g:go_auto_type_info = 1

augroup go
  autocmd FileType go nmap <leader>r  <Plug>(go-run)
  " autocmd FileType go nmap <leader>c  <Plug>(go-coverage-toggle)
  autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
  autocmd FileType go nmap <C-]> :GoDef
augroup end
