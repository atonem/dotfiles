" ==================================================
" CtrlP
" ==================================================

set wildignore+=*.so,*.swp,*.zip,*.pyc,*.pyo
let g:ctrlp_custom_ignore = 'node_modules\|bower_components\|templates_c'

" ==================================================
" gr opens Fuzzy tags search
" ==================================================
nmap gr :CtrlPBufTag<CR>
let g:ctrlp_buftag_types = {
\ 'go' : '--language-force=go --golang-types=ftv',
\ 'coffee' : '--language-force=coffee --coffee-types=cmfvf',
\ 'markdown' : '--language-force=markdown --markdown-types=hik',
\ 'objc' : '--language-force=objc --objc-types=mpci',
\ 'rc' : '--language-force=rust --rust-types=fTm'
\ }

" ==================================================
" Use ag for ctrlp if available
" ==================================================
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif
