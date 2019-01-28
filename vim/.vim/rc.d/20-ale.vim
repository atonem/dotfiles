let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'dart': ['dartfmt'],
\  'javascript': ['prettier', 'eslint'],
\  'vue': ['prettier', 'eslint'],
\  'json': ['prettier'],
\  'html': ['prettier'],
\  'markdown': ['prettier'],
\}

let g:ale_linter_aliases = {
\  'vue': ['vue', 'javascript']
\}

let g:ale_linters = {
\  'dart': ['language_server'],
\  'javascript': ['eslint'],
\  'vue': ['vls', 'eslint'],
\}

let g:ale_javascript_eslint_executable = 'eslint_d'

let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
"let g:ale_set_highlights = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_column_always = 1
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 0

let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_open_list = 1

