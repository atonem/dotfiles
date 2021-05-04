let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'javascript': ['prettier', 'eslint'],
\  'vue': ['prettier', 'eslint'],
\  'typescript': ['deno', 'eslint'],
\  'json': ['prettier'],
\  'yaml': ['prettier'],
\  'html': ['prettier'],
\  'markdown': ['prettier'],
\  'python': ['black', 'isort'],
\  'java': ['google_java_format'],
\  'xml': ['xmllint'],
\  'svelte': ['eslint', 'prettier'],
\  'typescriptreact': ['prettier', 'eslint'],
\  'css': ['prettier', 'eslint'],
\  'scss': ['prettier', 'eslint'],
\}

let g:ale_linter_aliases = {
\  'vue': ['vue', 'javascript', 'typescript'],
\  'typescript': ['javascript'],
\  'svelte': ['css', 'javascript'],
\  'typescriptreact': ['css', 'typescript', 'javascript'],
\}

let g:ale_linters = {
\  'dart': [ 'language_server'],
\  'javascript': ['eslint'],
\  'typescript': ['tsserver', 'eslint'],
\  'typescriptreact': ['tsserver', 'eslint'],
\  'vue': ['vls', 'eslint'],
\  'svelte': ['svelteserver', 'eslint', 'stylelint'],
\  'vim': ['vint'],
\  'proto': ['prototool-lint'],
\  'python': ['pyls', 'mypy', 'pylint'],
\  'xml': ['xmllint'],
\  'java': ['javac'],
\}
" \  'java': ['javalsp'],

" Javascript
" let g:ale_javascript_eslint_executable = 'eslint_d'

let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 0
let g:ale_lint_on_enter = 1
let g:ale_set_highlights = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_column_always = 1
let g:ale_sign_error = '*'
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
" let g:prototool_format_enable = 1
" let g:prototool_format_fix_flag = ''
let g:prototool_format_enable = 1
let g:prototool_format_fix_flag = '--fix '
" call PrototoolFormatFixEnable()

" Java
let g:ale_java_checkstyle_config = './google_checks.xml'
" To get ALE to use correct javac when using jenv
let g:ale_java_javac_executable = '/Users/anton/.jenv/shims/javac'
let g:ale_java_javac_sourcepath = ['src']
let g:ale_java_google_java_format_use_global = 1
" let g:ale_java_javalsp_executable = '/Users/anton/code/java-language-server/dist/lang_server_mac.sh'
" let b:ale_java_javalsp_config = { 'java': { 'classPath': LoadDeps(bufnr('%')) } }
" let g:ale_java_javalsp_config =
" \ {
" \   'java': {
" \     'externalDependencies': [
" \       'junit:junit:jar:4.12:test'
" \     ]
" \   }
" \ }
" \       '~/.m2/repository/'
" \     ],
" \     'classPath': [
" \       '/android-sdk/platforms/android-28.jar'



nmap ]a <Plug>(ale_next_wrap)
nmap [a <Plug>(ale_previous_wrap)
nmap <leader>i <Plug>(ale_fix)
nmap <C-]> :ALEGoToDefinition<CR>
" nmap <C-[> :ALEGoToDefinitionInVSplit<CR>

" augroup dart
"   autocmd! dart
"   autocmd Filetype dart nnoremap <buffer>  <C-]> :ALEGoToDefinition<CR>
"   autocmd Filetype dart nnoremap <buffer>  <C-[> :ALEGoToDefinitionInVSplit<CR>
" augroup end
