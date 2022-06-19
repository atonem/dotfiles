" Set fastlane files to ruby syntax
" Handled in ale
" augroup pythongroup
"   autocmd BufWritePre *.py execute ':Black'
" augroup END
let g:black_linelength=80
let g:ale_python_black_use_global = 1
let g:ale_python_black_change_directory = 0
let g:ale_python_pyls_use_global = 1
