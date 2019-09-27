
let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'dart': ['dartfmt'],
\  'javascript': ['prettier', 'eslint'],
\  'vue': ['prettier', 'eslint'],
\  'json': ['prettier'],
\  'yaml': ['prettier'],
\  'html': ['prettier'],
\  'markdown': ['prettier'],
\  'python': ['black', 'isort'],
\  'java': ['google_java_format'],
\}

let g:ale_linter_aliases = {
\  'vue': ['vue', 'javascript']
\}

let g:ale_linters = {
\  'dart': ['language_server'],
\  'javascript': ['eslint'],
\  'vue': ['vls', 'eslint'],
\  'vim': ['vint'],
\  'proto': ['prototool-lint'],
\  'python': ['pyls'],
\}

let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_fix_on_save = 1
let g:ale_lint_on_enter = 1
let g:ale_set_highlights = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_column_always = 1
let g:ale_sign_error = '='
let g:ale_sign_warning = '-'
let g:ale_lint_on_enter = 0

let g:ale_set_loclist = 0
let g:ale_set_quickeix = 1
let g:ale_open_list = 1
let g:ale_statusline_format = ['E%d', 'W%d', 'K']
let g:ale_lint_delay = 350
let g:ale_sign_column_always = 1
" set completeopt=menu,menuone,preview,noselect,noinsert
let g:ale_completion_enabled = 1

" Enable protobuf
" call PrototoolFormatEnable()
let g:prototool_format_enable = 1
let g:prototool_format_fix_flag = ''
let g:prototool_format_enable = 1
let g:prototool_format_fix_flag = '--fix '
" call PrototoolFormatFixEnable()

" Java
let g:ale_java_checkstyle_config = './google_checks.xml'
" To get ALE to use correct javac when using jenv
let g:ale_java_javac_executable = '$HOME/.jenv/shims/javac'


nmap ]a <Plug>(ale_next_wrap)
nmap [a <Plug>(ale_previous_wrap)

augroup dart
  autocmd! dart
  autocmd Filetype dart nnoremap <buffer>  <C-]> :ALEGoToDefinition<CR>
  " autocmd Filetype dart nnoremap <buffer>  <C-[> :ALEGoToDefinitionInVSplit<CR>
augroup end
