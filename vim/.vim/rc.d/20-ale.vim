
let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'dart': ['dartfmt'],
\  'javascript': ['prettier', 'eslint'],
\  'vue': ['prettier', 'eslint'],
\  'json': ['prettier'],
\  'yaml': ['prettier'],
\  'html': ['prettier'],
\  'markdown': ['prettier'],
\  'python': [
  \   'isort',
\   'yapf',
\  ],
\}

let g:ale_linter_aliases = {
\  'vue': ['vue', 'javascript']
\}

let g:ale_linters = {
\  'dart': ['language_server'],
\  'javascript': ['eslint'],
\  'vue': ['vls', 'eslint'],
\  'vim': ['vint'],
\   'proto': ['prototool-lint'],
\}

let g:ale_javascript_eslint_executable = 'eslint_d'

let g:ale_fix_on_save = 1
let g:ale_set_highlights = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_column_always = 1
let g:ale_sign_error = '='
let g:ale_sign_warning = '-'
let g:ale_lint_on_enter = 0

let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_open_list = 1

" Enable protobuf
" call PrototoolFormatEnable()
let g:prototool_format_enable = 1
let g:prototool_format_fix_flag = ''
let g:prototool_format_enable = 1
let g:prototool_format_fix_flag = '--fix '
" call PrototoolFormatFixEnable()

nmap ]a <Plug>(ale_next_wrap)
nmap [a <Plug>(ale_previous_wrap)

augroup dart
  autocmd! dart
  autocmd Filetype dart nnoremap <buffer>  <C-]> :ALEGoToDefinition<CR>
  " autocmd Filetype dart nnoremap <buffer>  <C-[> :ALEGoToDefinitionInVSplit<CR>
augroup end
