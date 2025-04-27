" vim-plug: Vim plugin manager
" ============================
"
" Download plug.vim and put it in ~/.vim/autoload
"
"   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" Edit your .vimrc
"
"   call plug#begin('~/.vim/plugged')
"
"   " Make sure you use single quotes
"
"   " Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
"   Plug 'junegunn/vim-easy-align'
"
"   " Any valid git URL is allowed
"   Plug 'https://github.com/junegunn/vim-github-dashboard.git'
"
"   " Multiple Plug commands can be written in a single line using | separators
"   Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
"
"   " On-demand loading
"   Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
"   Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
"
"   " Using a non-default branch
"   Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
"
"   " Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
"   Plug 'fatih/vim-go', { 'tag': '*' }
"
"   " Plugin options
"   Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
"
"   " Plugin outside ~/.vim/plugged with post-update hook
"   Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"
"   " Unmanaged plugin (manually installed and updated)
"   Plug '~/my-prototype-plugin'
"
"   " Initialize plugin system
"   call plug#end()
"
" Then reload .vimrc and :PlugInstall to install plugins.
"
" Plug options:
"
"| Option                  | Description                                      |
"| ----------------------- | ------------------------------------------------ |
"| `branch`/`tag`/`commit` | Branch/tag/commit of the repository to use       |
"| `rtp`                   | Subdirectory that contains Vim plugin            |
"| `dir`                   | Custom directory for the plugin                  |
"| `as`                    | Use different name for the plugin                |
"| `do`                    | Post-update hook (string or funcref)             |
"| `on`                    | On-demand loading: Commands or `<Plug>`-mappings |
"| `for`                   | On-demand loading: File types                    |
"| `frozen`                | Do not update unless explicitly specified        |
"
" More information: https://github.com/junegunn/vim-plug
"
"
" Copyright (c) 2017 Junegunn Choi
"
" MIT License
"
" Permission is hereby granted, free of charge, to any person obtaining
" a copy of this software and associated documentation files (the
" "Software"), to deal in the Software without restriction, including
" without limitation the rights to use, copy, modify, merge, publish,
" distribute, sublicense, and/or sell copies of the Software, and to
" permit persons to whom the Software is furnished to do so, subject to
" the following conditions:
"
" The above copyright notice and this permission notice shall be
" included in all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
" EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
" MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
" NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
" LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
" OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
" WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

if exists('g:loaded_plug')
  finish
endif
let g:loaded_plug = 1

let s:cpo_save = &cpo
set cpo&vim

let s:plug_src = 'https://github.com/junegunn/vim-plug.git'
let s:plug_tab = get(s:, 'plug_tab', -1)
let s:plug_buf = get(s:, 'plug_buf', -1)
let s:mac_gui = has('gui_macvim') && has('gui_running')
let s:is_win = has('win32')
let s:nvim = has('nvim-0.2') || (has('nvim') && exists('*jobwait') && !s:is_win)
let s:vim8 = has('patch-8.0.0039') && exists('*job_start')
if s:is_win && &shellslash
  set noshellslash
  let s:me = resolve(expand('<sfile>:p'))
  set shellslash
else
  let s:me = resolve(expand('<sfile>:p'))
endif
let s:base_spec = { 'branch': '', 'frozen': 0 }
let s:TYPE = {
\   'string':  type(''),
\   'list':    type([]),
\   'dict':    type({}),
\   'funcref': type(function('call'))
\ }
let s:loaded = get(s:, 'loaded', {})
let s:triggers = get(s:, 'triggers', {})

function! s:is_powershell(shell)
  return a:shell =~# 'powershell\(\.exe\)\?$' || a:shell =~# 'pwsh\(\.exe\)\?$'
endfunction

function! s:isabsolute(dir) abort
  return a:dir =~# '^/' || (has('win32') && a:dir =~? '^\%(\\\|[A-Z]:\)')
endfunction

function! s:git_dir(dir) abort
  let gitdir = s:trim(a:dir) . '/.git'
  if isdirectory(gitdir)
    return gitdir
  endif
  if !filereadable(gitdir)
    return ''
  endif
  let gitdir = matchstr(get(readfile(gitdir), 0, ''), '^gitdir: \zs.*')
  if len(gitdir) && !s:isabsolute(gitdir)
    let gitdir = a:dir . '/' . gitdir
  endif
  return isdirectory(gitdir) ? gitdir : ''
endfunction

function! s:git_origin_url(dir) abort
  let gitdir = s:git_dir(a:dir)
  let config = gitdir . '/config'
  if empty(gitdir) || !filereadable(config)
    return ''
  endif
  return matchstr(join(readfile(config)), '\[remote "origin"\].\{-}url\s*=\s*\zs\S*\ze')
endfunction

function! s:git_revision(dir) abort
  let gitdir = s:git_dir(a:dir)
  let head = gitdir . '/HEAD'
  if empty(gitdir) || !filereadable(head)
    return ''
  endif

  let line = get(readfile(head), 0, '')
  let ref = matchstr(line, '^ref: \zs.*')
  if empty(ref)
    return line
  endif

  if filereadable(gitdir . '/' . ref)
    return get(readfile(gitdir . '/' . ref), 0, '')
  endif

  if filereadable(gitdir . '/packed-refs')
    for line in readfile(gitdir . '/packed-refs')
      if line =~# ' ' . ref
        return matchstr(line, '^[0-9a-f]*')
      endif
    endfor
  endif

  return ''
endfunction

function! s:git_local_branch(dir) abort
  let gitdir = s:git_dir(a:dir)
  let head = gitdir . '/HEAD'
  if empty(gitdir) || !filereadable(head)
    return ''
  endif
  let branch = matchstr(get(readfile(head), 0, ''), '^ref: refs/heads/\zs.*')
  return len(branch) ? branch : 'HEAD'
endfunction

function! s:git_origin_branch(spec)
  if len(a:spec.branch)
    return a:spec.branch
  endif

  " The file may not be present if this is a local repository
  let gitdir = s:git_dir(a:spec.dir)
  let origin_head = gitdir.'/refs/remotes/origin/HEAD'
  if len(gitdir) && filereadable(origin_head)
    return matchstr(get(readfile(origin_head), 0, ''),
                  \ '^ref: refs/remotes/origin/\zs.*')
  endif

  " The command may not return the name of a branch in detached HEAD state
  let result = s:lines(s:system('git symbolic-ref --short HEAD', a:spec.dir))
  return v:shell_error ? '' : result[-1]
endfunction

if s:is_win
  function! s:plug_call(fn, ...)
    let shellslash = &shellslash
    try
      set noshellslash
      return call(a:fn, a:000)
    finally
      let &shellslash = shellslash
    endtry
  endfunction
else
  function! s:plug_call(fn, ...)
    return call(a:fn, a:000)
  endfunction
endif

function! s:plug_getcwd()
  return s:plug_call('getcwd')
endfunction

function! s:plug_fnamemodify(fname, mods)
  return s:plug_call('fnamemodify', a:fname, a:mods)
endfunction

function! s:plug_expand(fmt)
  return s:plug_call('expand', a:fmt, 1)
endfunction

function! s:plug_tempname()
  return s:plug_call('tempname')
endfunction

function! plug#begin(...)
  if a:0 > 0
    let s:plug_home_org = a:1
    let home = s:path(s:plug_fnamemodify(s:plug_expand(a:1), ':p'))
  elseif exists('g:plug_home')
    let home = s:path(g:plug_home)
  elseif has('nvim')
    let home = stdpath('data') . '/plugged'
  elseif !empty(&rtp)
    let home = s:path(split(&rtp, ',')[0]) . '/plugged'
  else
    return s:err('Unable to determine plug home. Try calling plug#begin() with a path argument.')
  endif
  if s:plug_fnamemodify(home, ':t') ==# 'plugin' && s:plug_fnamemodify(home, ':h') ==# s:first_rtp
    return s:err('Invalid plug home. '.home.' is a standard Vim runtime path and is not allowed.')
  endif

  let g:plug_home = home
  let g:plugs = {}
  let g:plugs_order = []
  let s:triggers = {}

  call s:define_commands()
  return 1
endfunction

function! s:define_commands()
  command! -nargs=+ -bar Plug call plug#(<args>)
  if !executable('git')
    return s:err('`git` executable not found. Most commands will not be available. To suppress this message, prepend `silent!` to `call plug#begin(...)`.')
  endif
  if has('win32')
  \ && &shellslash
  \ && (&shell =~# 'cmd\(\.exe\)\?$' || s:is_powershell(&shell))
    return s:err('vim-plug does not support shell, ' . &shell . ', when shellslash is set.')
  endif
  if !has('nvim')
    \ && (has('win32') || has('win32unix'))
    \ && !has('multi_byte')
    return s:err('Vim needs +multi_byte feature on Windows to run shell commands. Enable +iconv for best results.')
  endif
  command! -nargs=* -bar -bang -complete=customlist,s:names PlugInstall call s:install(<bang>0, [<f-args>])
  command! -nargs=* -bar -bang -complete=customlist,s:names PlugUpdate  call s:update(<bang>0, [<f-args>])
  command! -nargs=0 -bar -bang PlugClean call s:clean(<bang>0)
  command! -nargs=0 -bar PlugUpgrade if s:upgrade() | execute 'source' s:esc(s:me) | endif
  command! -nargs=0 -bar PlugStatus  call s:status()
  command! -nargs=0 -bar PlugDiff    call s:diff()
  command! -nargs=? -bar -bang -complete=file PlugSnapshot call s:snapshot(<bang>0, <f-args>)
endfunction

function! s:to_a(v)
  return type(a:v) == s:TYPE.list ? a:v : [a:v]
endfunction

function! s:to_s(v)
  return type(a:v) == s:TYPE.string ? a:v : join(a:v, "\n") . "\n"
endfunction

function! s:glob(from, pattern)
  return s:lines(globpath(a:from, a:pattern))
endfunction

function! s:source(from, ...)
  let found = 0
  for pattern in a:000
    for vim in s:glob(a:from, pattern)
      execute 'source' s:esc(vim)
      let found = 1
    endfor
  endfor
  return found
endfunction

function! s:assoc(dict, key, val)
  let a:dict[a:key] = add(get(a:dict, a:key, []), a:val)
endfunction

function! s:ask(message, ...)
  call inputsave()
  echohl WarningMsg
  let answer = input(a:message.(a:0 ? ' (y/N/a) ' : ' (y/N) '))
  echohl None
  call inputrestore()
  echo "\r"
  return (a:0 && answer =~? '^a') ? 2 : (answer =~? '^y') ? 1 : 0
endfunction

function! s:ask_no_interrupt(...)
  try
    return call('s:ask', a:000)
  catch
    return 0
  endtry
endfunction

function! s:lazy(plug, opt)
  return has_key(a:plug, a:opt) &&
        \ (empty(s:to_a(a:plug[a:opt]))         ||
        \  !isdirectory(a:plug.dir)             ||
        \  len(s:glob(s:rtp(a:plug), 'plugin')) ||
        \  len(s:glob(s:rtp(a:plug), 'after/plugin')))
endfunction

function! plug#end()
  if !exists('g:plugs')
    return s:err('plug#end() called without calling plug#begin() first')
  endif

  if exists('#PlugLOD')
    augroup PlugLOD
      autocmd!
    augroup END
    augroup! PlugLOD
  endif
  let lod = { 'ft': {}, 'map': {}, 'cmd': {} }

  if get(g:, 'did_load_filetypes', 0)
    filetype off
  endif
  for name in g:plugs_order
    if !has_key(g:plugs, name)
      continue
    endif
    let plug = g:plugs[name]
    if get(s:loaded, name, 0) || !s:lazy(plug, 'on') && !s:lazy(plug, 'for')
      let s:loaded[name] = 1
      continue
    endif

    if has_key(plug, 'on')
      let s:triggers[name] = { 'map': [], 'cmd': [] }
      for cmd in s:to_a(plug.on)
        if cmd =~? '^<Plug>.\+'
          if empty(mapcheck(cmd)) && empty(mapcheck(cmd, 'i'))
            call s:assoc(lod.map, cmd, name)
          endif
          call add(s:triggers[name].map, cmd)
        elseif cmd =~# '^[A-Z]'
          let cmd = substitute(cmd, '!*$', '', '')
          if exists(':'.cmd) != 2
            call s:assoc(lod.cmd, cmd, name)
          endif
          call add(s:triggers[name].cmd, cmd)
        else
          call s:err('Invalid `on` option: '.cmd.
          \ '. Should start with an uppercase letter or `<Plug>`.')
        endif
      endfor
    endif

    if has_key(plug, 'for')
      let types = s:to_a(plug.for)
      if !empty(types)
        augroup filetypedetect
        call s:source(s:rtp(plug), 'ftdetect/**/*.vim', 'after/ftdetect/**/*.vim')
        if has('nvim-0.5.0')
          call s:source(s:rtp(plug), 'ftdetect/**/*.lua', 'after/ftdetect/**/*.lua')
        endif
        augroup END
      endif
      for type in types
        call s:assoc(lod.ft, type, name)
      endfor
    endif
  endfor

  for [cmd, names] in items(lod.cmd)
    execute printf(
    \ 'command! -nargs=* -range -bang -complete=file %s call s:lod_cmd(%s, "<bang>", <line1>, <line2>, <q-args>, %s)',
    \ cmd, string(cmd), string(names))
  endfor

  for [map, names] in items(lod.map)
    for [mode, map_prefix, key_prefix] in
          \ [['i', '<C-\><C-O>', ''], ['n', '', ''], ['v', '', 'gv'], ['o', '', '']]
      execute printf(
      \ '%snoremap <silent> %s %s:<C-U>call <SID>lod_map(%s, %s, %s, "%s")<CR>',
      \ mode, map, map_prefix, string(map), string(names), mode != 'i', key_prefix)
    endfor
  endfor

  for [ft, names] in items(lod.ft)
    augroup PlugLOD
      execute printf('autocmd FileType %s call <SID>lod_ft(%s, %s)',
            \ ft, string(ft), string(names))
    augroup END
  endfor

  call s:reorg_rtp()
  filetype plugin indent on
  if has('vim_starting')
    if has('syntax') && !exists('g:syntax_on')
      syntax enable
    end
  else
    call s:reload_plugins()
  endif
endfunction

function! s:loaded_names()
  return filter(copy(g:plugs_order), 'get(s:loaded, v:val, 0)')
endfunction

function! s:load_plugin(spec)
  call s:source(s:rtp(a:spec), 'plugin/**/*.vim', 'after/plugin/**/*.vim')
  if has('nvim-0.5.0')
    call s:source(s:rtp(a:spec), 'plugin/**/*.lua', 'after/plugin/**/*.lua')
  endif
endfunction

function! s:reload_plugins()
  for name in s:loaded_names()
    call s:load_plugin(g:plugs[name])
  endfor
endfunction

function! s:trim(str)
  return substitute(a:str, '[\/]\+$', '', '')
endfunction

function! s:version_requirement(val, min)
  for idx in range(0, len(a:min) - 1)
    let v = get(a:val, idx, 0)
    if     v < a:min[idx] | return 0
    elseif v > a:min[idx] | return 1
    endif
  endfor
  return 1
endfunction

function! s:git_version_requirement(...)
  if !exists('s:git_version')
    let s:git_version = map(split(split(s:system(['git', '--version']))[2], '\.'), 'str2nr(v:val)')
  endif
  return s:version_requirement(s:git_version, a:000)
endfunction

function! s:progress_opt(base)
  return a:base && !s:is_win &&
        \ s:git_version_requirement(1, 7, 1) ? '--progress' : ''
endfunction

function! s:rtp(spec)
  return s:path(a:spec.dir . get(a:spec, 'rtp', ''))
endfunction

if s:is_win
  function! s:path(path)
    return s:trim(substitute(a:path, '/', '\', 'g'))
  endfunction

  function! s:dirpath(path)
    return s:path(a:path) . '\'
  endfunction

  function! s:is_local_plug(repo)
    return a:repo =~? '^[a-z]:\|^[%~]'
  endfunction

  " Copied from fzf
  function! s:wrap_cmds(cmds)
    let cmds = [
      \ '@echo off',
      \ 'setlocal enabledelayedexpansion']
    \ + (type(a:cmds) == type([]) ? a:cmds : [a:cmds])
    \ + ['endlocal']
    if has('iconv')
      if !exists('s:codepage')
        let s:codepage = libcallnr('kernel32.dll', 'GetACP', 0)
      endif
      return map(cmds, printf('iconv(v:val."\r", "%s", "cp%d")', &encoding, s:codepage))
    endif
    return map(cmds, 'v:val."\r"')
  endfunction

  function! s:batchfile(cmd)
    let batchfile = s:plug_tempname().'.bat'
    call writefile(s:wrap_cmds(a:cmd), batchfile)
    let cmd = plug#shellescape(batchfile, {'shell': &shell, 'script': 0})
    if s:is_powershell(&shell)
      let cmd = '& ' . cmd
    endif
    return [batchfile, cmd]
  endfunction
else
  function! s:path(path)
    return s:trim(a:path)
  endfunction

  function! s:dirpath(path)
    return substitute(a:path, '[/\\]*$', '/', '')
  endfunction

  function! s:is_local_plug(repo)
    return a:repo[0] =~ '[/$~]'
  endfunction
endif

function! s:err(msg)
  echohl ErrorMsg
  echom '[vim-plug] '.a:msg
  echohl None
endfunction

function! s:warn(cmd, msg)
  echohl WarningMsg
  execute a:cmd 'a:msg'
  echohl None
endfunction

function! s:esc(path)
  return escape(a:path, ' ')
endfunction

function! s:escrtp(path)
  return escape(a:path, ' ,')
endfunction

function! s:remove_rtp()
  for name in s:loaded_names()
    let rtp = s:rtp(g:plugs[name])
    execute 'set rtp-='.s:escrtp(rtp)
    let after = globpath(rtp, 'after')
    if isdirectory(after)
      execute 'set rtp-='.s:escrtp(after)
    endif
  endfor
endfunction

function! s:reorg_rtp()
  if !empty(s:first_rtp)
    execute 'set rtp-='.s:first_rtp
    execute 'set rtp-='.s:last_rtp
  endif

  " &rtp is modified from outside
  if exists('s:prtp') && s:prtp !=# &rtp
    call s:remove_rtp()
    unlet! s:middle
  endif

  let s:middle = get(s:, 'middle', &rtp)
  let rtps     = map(s:loaded_names(), 's:rtp(g:plugs[v:val])')
  let afters   = filter(map(copy(rtps), 'globpath(v:val, "after")'), '!empty(v:val)')
  let rtp      = join(map(rtps, 'escape(v:val, ",")'), ',')
                 \ . ','.s:middle.','
                 \ . join(map(afters, 'escape(v:val, ",")'), ',')
  let &rtp     = substitute(substitute(rtp, ',,*', ',', 'g'), '^,\|,$', '', 'g')
  let s:prtp   = &rtp

  if !empty(s:first_rtp)
    execute 'set rtp^='.s:first_rtp
    execute 'set rtp+='.s:last_rtp
  endif
endfunction

function! s:doautocmd(...)
  if exists('#'.join(a:000, '#'))
    execute 'doautocmd' ((v:version > 703 || has('patch442')) ? '<nomodeline>' : '') join(a:000)
  endif
endfunction

function! s:dobufread(names)
  for name in a:names
    let path = s:rtp(g:plugs[name])
    for dir in ['ftdetect', 'ftplugin', 'after/ftdetect', 'after/ftplugin']
      if len(finddir(dir, path))
        if exists('#BufRead')
          doautocmd BufRead
        endif
        return
      endif
    endfor
  endfor
endfunction

function! plug#load(...)
  if a:0 == 0
    return s:err('Argument missing: plugin name(s) required')
  endif
  if !exists('g:plugs')
    return s:err('plug#begin was not called')
  endif
  let names = a:0 == 1 && type(a:1) == s:TYPE.list ? a:1 : a:000
  let unknowns = filter(copy(names), '!has_key(g:plugs, v:val)')
  if !empty(unknowns)
    let s = len(unknowns) > 1 ? 's' : ''
    return s:err(printf('Unknown plugin%s: %s', s, join(unknowns, ', ')))
  end
  let unloaded = filter(copy(names), '!get(s:loaded, v:val, 0)')
  if !empty(unloaded)
    for name in unloaded
      call s:lod([name], ['ftdetect', 'after/ftdetect', 'plugin', 'after/plugin'])
    endfor
    call s:dobufread(unloaded)
    return 1
  end
  return 0
endfunction

function! s:remove_triggers(name)
  if !has_key(s:triggers, a:name)
    return
  endif
  for cmd in s:triggers[a:name].cmd
    execute 'silent! delc' cmd
  endfor
  for map in s:triggers[a:name].map
    execute 'silent! unmap' map
    execute 'silent! iunmap' map
  endfor
  call remove(s:triggers, a:name)
endfunction

function! s:lod(names, types, ...)
  for name in a:names
    call s:remove_triggers(name)
    let s:loaded[name] = 1
  endfor
  call s:reorg_rtp()

  for name in a:names
    let rtp = s:rtp(g:plugs[name])
    for dir in a:types
      call s:source(rtp, dir.'/**/*.vim')
      if has('nvim-0.5.0')  " see neovim#14686
        call s:source(rtp, dir.'/**/*.lua')
      endif
    endfor
    if a:0
      if !s:source(rtp, a:1) && !empty(s:glob(rtp, a:2))
        execute 'runtime' a:1
      endif
      call s:source(rtp, a:2)
    endif
    call s:doautocmd('User', name)
  endfor
endfunction

function! s:lod_ft(pat, names)
  let syn = 'syntax/'.a:pat.'.vim'
  call s:lod(a:names, ['plugin', 'after/plugin'], syn, 'after/'.syn)
  execute 'autocmd! PlugLOD FileType' a:pat
  call s:doautocmd('filetypeplugin', 'FileType')
  call s:doautocmd('filetypeindent', 'FileType')
endfunction

function! s:lod_cmd(cmd, bang, l1, l2, args, names)
  call s:lod(a:names, ['ftdetect', 'after/ftdetect', 'plugin', 'after/plugin'])
  call s:dobufread(a:names)
  execute printf('%s%s%s %s', (a:l1 == a:l2 ? '' : (a:l1.','.a:l2)), a:cmd, a:bang, a:args)
endfunction

function! s:lod_map(map, names, with_prefix, prefix)
  call s:lod(a:names, ['ftdetect', 'after/ftdetect', 'plugin', 'after/plugin'])
  call s:dobufread(a:names)
  let extra = ''
  while 1
    let c = getchar(0)
    if c == 0
      break
    endif
    let extra .= nr2char(c)
  endwhile

  if a:with_prefix
    let prefix = v:count ? v:count : ''
    let prefix .= '"'.v:register.a:prefix
    if mode(1) == 'no'
      if v:operator == 'c'
        let prefix = "\<esc>" . prefix
      endif
      let prefix .= v:operator
    endif
    call feedkeys(prefix, 'n')
  endif
  call feedkeys(substitute(a:map, '^<Plug>', "\<Plug>", '') . extra)
endfunction

function! plug#(repo, ...)
  if a:0 > 1
    return s:err('Invalid number of arguments (1..2)')
  endif

  try
    let repo = s:trim(a:repo)
    let opts = a:0 == 1 ? s:parse_options(a:1) : s:base_spec
    let name = get(opts, 'as', s:plug_fnamemodify(repo, ':t:s?\.git$??'))
    let spec = extend(s:infer_properties(name, repo), opts)
    if !has_key(g:plugs, name)
      call add(g:plugs_order, name)
    endif
    let g:plugs[name] = spec
    let s:loaded[name] = get(s:loaded, name, 0)
  catch
    return s:err(repo . ' ' . v:exception)
  endtry
endfunction

function! s:parse_options(arg)
  let opts = copy(s:base_spec)
  let type = type(a:arg)
  let opt_errfmt = 'Invalid argument for "%s" option of :Plug (expected: %s)'
  if type == s:TYPE.string
    if empty(a:arg)
      throw printf(opt_errfmt, 'tag', 'string')
    endif
    let opts.tag = a:arg
  elseif type == s:TYPE.dict
    for opt in ['branch', 'tag', 'commit', 'rtp', 'dir', 'as']
      if has_key(a:arg, opt)
      \ && (type(a:arg[opt]) != s:TYPE.string || empty(a:arg[opt]))
        throw printf(opt_errfmt, opt, 'string')
      endif
    endfor
    for opt in ['on', 'for']
      if has_key(a:arg, opt)
      \ && type(a:arg[opt]) != s:TYPE.list
      \ && (type(a:arg[opt]) != s:TYPE.string || empty(a:arg[opt]))
        throw printf(opt_errfmt, opt, 'string or list')
      endif
    endfor
    if has_key(a:arg, 'do')
      \ && type(a:arg.do) != s:TYPE.funcref
      \ && (type(a:arg.do) != s:TYPE.string || empty(a:arg.do))
        throw printf(opt_errfmt, 'do', 'string or funcref')
    endif
    call extend(opts, a:arg)
    if has_key(opts, 'dir')
      let opts.dir = s:dirpath(s:plug_expand(opts.dir))
    endif
  else
    throw 'Invalid argument type (expected: string or dictionary)'
  endif
  return opts
endfunction

function! s:infer_properties(name, repo)
  let repo = a:repo
  if s:is_local_plug(repo)
    return { 'dir': s:dirpath(s:plug_expand(repo)) }
  else
    if repo =~ ':'
      let uri = repo
    else
      if repo !~ '/'
        throw printf('Invalid argument: %s (implicit `vim-scripts'' expansion is deprecated)', repo)
      endif
      let fmt = get(g:, 'plug_url_format', 'https://git::@github.com/%s.git')
      let uri = printf(fmt, repo)
    endif
    return { 'dir': s:dirpath(g:plug_home.'/'.a:name), 'uri': uri }
  endif
endfunction

function! s:install(force, names)
  call s:update_impl(0, a:force, a:names)
endfunction

function! s:update(force, names)
  call s:update_impl(1, a:force, a:names)
endfunction

function! plug#helptags()
  if !exists('g:plugs')
    return s:err('plug#begin was not called')
  endif
  for spec in values(g:plugs)
    let docd = join([s:rtp(spec), 'doc'], '/')
    if isdirectory(docd)
      silent! execute 'helptags' s:esc(docd)
    endif
  endfor
  return 1
endfunction

function! s:syntax()
  syntax clear
  syntax region plug1 start=/\%1l/ end=/\%2l/ contains=plugNumber
  syntax region plug2 start=/\%2l/ end=/\%3l/ contains=plugBracket,plugX
  syn match plugNumber /[0-9]\+[0-9.]*/ contained
  syn match plugBracket /[[\]]/ contained
  syn match plugX /x/ contained
  syn match plugDash /^-\{1}\ /
  syn match plugPlus /^+/
  syn match plugStar /^*/
  syn match plugMessage /\(^- \)\@<=.*/
  syn match plugName /\(^- \)\@<=[^ ]*:/
  syn match plugSha /\%(: \)\@<=[0-9a-f]\{4,}$/
  syn match plugTag /(tag: [^)]\+)/
  syn match plugInstall /\(^+ \)\@<=[^:]*/
  syn match plugUpdate /\(^* \)\@<=[^:]*/
  syn match plugCommit /^  \X*[0-9a-f]\{7,9} .*/ contains=plugRelDate,plugEdge,plugTag
  syn match plugEdge /^  \X\+$/
  syn match plugEdge /^  \X*/ contained nextgroup=plugSha
  syn match plugSha /[0-9a-f]\{7,9}/ contained
  syn match plugRelDate /([^)]*)$/ contained
  syn match plugNotLoaded /(not loaded)$/
  syn match plugError /^x.*/
  syn region plugDeleted start=/^\~ .*/ end=/^\ze\S/
  syn match plugH2 /^.*:\n-\+$/
  syn match plugH2 /^-\{2,}/
  syn keyword Function PlugInstall PlugStatus PlugUpdate PlugClean
  hi def link plug1       Title
  hi def link plug2       Repeat
  hi def link plugH2      Type
  hi def link plugX       Exception
  hi def link plugBracket Structure
  hi def link plugNumber  Number

  hi def link plugDash    Special
  hi def link plugPlus    Constant
  hi def link plugStar    Boolean

  hi def link plugMessage Function
  hi def link plugName    Label
  hi def link plugInstall Function
  hi def link plugUpdate  Type

  hi def link plugError   Error
  hi def link plugDeleted Ignore
  hi def link plugRelDate Comment
  hi def link plugEdge    PreProc
  hi def link plugSha     Identifier
  hi def link plugTag     Constant

  hi def link plugNotLoaded Comment
endfunction

function! s:lpad(str, len)
  return a:str . repeat(' ', a:len - len(a:str))
endfunction

function! s:lines(msg)
  return split(a:msg, "[\r\n]")
endfunction

function! s:lastline(msg)
  return get(s:lines(a:msg), -1, '')
endfunction

function! s:new_window()
  execute get(g:, 'plug_window', 'vertical topleft new')
endfunction

function! s:plug_window_exists()
  let buflist = tabpagebuflist(s:plug_tab)
  return !empty(buflist) && index(buflist, s:plug_buf) >= 0
endfunction

function! s:switch_in()
  if !s:plug_window_exists()
    return 0
  endif

  if winbufnr(0) != s:plug_buf
    let s:pos = [tabpagenr(), winnr(), winsaveview()]
    execute 'normal!' s:plug_tab.'gt'
    let winnr = bufwinnr(s:plug_buf)
    execute winnr.'wincmd w'
    call add(s:pos, winsaveview())
  else
    let s:pos = [winsaveview()]
  endif

  setlocal modifiable
  return 1
endfunction

function! s:switch_out(...)
  call winrestview(s:pos[-1])
  setlocal nomodifiable
  if a:0 > 0
    execute a:1
  endif

  if len(s:pos) > 1
    execute 'normal!' s:pos[0].'gt'
    execute s:pos[1] 'wincmd w'
    call winrestview(s:pos[2])
  endif
endfunction

function! s:finish_bindings()
  nnoremap <silent> <buffer> R  :call <SID>retry()<cr>
  nnoremap <silent> <buffer> D  :PlugDiff<cr>
  nnoremap <silent> <buffer> S  :PlugStatus<cr>
  nnoremap <silent> <buffer> U  :call <SID>status_update()<cr>
  xnoremap <silent> <buffer> U  :call <SID>status_update()<cr>
  nnoremap <silent> <buffer> ]] :silent! call <SID>section('')<cr>
  nnoremap <silent> <buffer> [[ :silent! call <SID>section('b')<cr>
endfunction

function! s:prepare(...)
  if empty(s:plug_getcwd())
    throw 'Invalid current working directory. Cannot proceed.'
  endif

  for evar in ['$GIT_DIR', '$GIT_WORK_TREE']
    if exists(evar)
      throw evar.' detected. Cannot proceed.'
    endif
  endfor

  call s:job_abort()
  if s:switch_in()
    if b:plug_preview == 1
      pc
    endif
    enew
  else
    call s:new_window()
  endif

  nnoremap <silent> <buffer> q :call <SID>close_pane()<cr>
  if a:0 == 0
    call s:finish_bindings()
  endif
  let b:plug_preview = -1
  let s:plug_tab = tabpagenr()
  let s:plug_buf = winbufnr(0)
  call s:assign_name()

  for k in ['<cr>', 'L', 'o', 'X', 'd', 'dd']
    execute 'silent! unmap <buffer>' k
  endfor
  setlocal buftype=nofile bufhidden=wipe nobuflisted nolist noswapfile nowrap cursorline modifiable nospell
  if exists('+colorcolumn')
    setlocal colorcolumn=
  endif
  setf vim-plug
  if exists('g:syntax_on')
    call s:syntax()
  endif
endfunction

function! s:close_pane()
  if b:plug_preview == 1
    pc
    let b:plug_preview = -1
  else
    bd
  endif
endfunction

function! s:assign_name()
  " Assign buffer name
  let prefix = '[Plugins]'
  let name   = prefix
  let idx    = 2
  while bufexists(name)
    let name = printf('%s (%s)', prefix, idx)
    let idx = idx + 1
  endwhile
  silent! execute 'f' fnameescape(name)
endfunction

function! s:chsh(swap)
  let prev = [&shell, &shellcmdflag, &shellredir]
  if !s:is_win
    set shell=sh
  endif
  if a:swap
    if s:is_powershell(&shell)
      let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s'
    elseif &shell =~# 'sh' || &shell =~# 'cmd\(\.exe\)\?$'
      set shellredir=>%s\ 2>&1
    endif
  endif
  return prev
endfunction

function! s:bang(cmd, ...)
  let batchfile = ''
  try
    let [sh, shellcmdflag, shrd] = s:chsh(a:0)
    " FIXME: Escaping is incomplete. We could use shellescape with eval,
    "        but it won't work on Windows.
    let cmd = a:0 ? s:with_cd(a:cmd, a:1) : a:cmd
    if s:is_win
      let [batchfile, cmd] = s:batchfile(cmd)
    endif
    let g:_plug_bang = (s:is_win && has('gui_running') ? 'silent ' : '').'!'.escape(cmd, '#!%')
    execute "normal! :execute g:_plug_bang\<cr>\<cr>"
  finally
    unlet g:_plug_bang
    let [&shell, &shellcmdflag, &shellredir] = [sh, shellcmdflag, shrd]
    if s:is_win && filereadable(batchfile)
      call delete(batchfile)
    endif
  endtry
  return v:shell_error ? 'Exit status: ' . v:shell_error : ''
endfunction

function! s:regress_bar()
  let bar = substitute(getline(2)[1:-2], '.*\zs=', 'x', '')
  call s:progress_bar(2, bar, len(bar))
endfunction

function! s:is_updated(dir)
  return !empty(s:system_chomp(['git', 'log', '--pretty=format:%h', 'HEAD...HEAD@{1}'], a:dir))
endfunction

function! s:do(pull, force, todo)
  if has('nvim')
    " Reset &rtp to invalidate Neovim cache of loaded Lua modules
    " See https://github.com/junegunn/vim-plug/pull/1157#issuecomment-1809226110
    let &rtp = &rtp
  endif
  for [name, spec] in items(a:todo)
    if !isdirectory(spec.dir)
      continue
    endif
    let installed = has_key(s:update.new, name)
    let updated = installed ? 0 :
      \ (a:pull && index(s:update.errors, name) < 0 && s:is_updated(spec.dir))
    if a:force || installed || updated
      execute 'cd' s:esc(spec.dir)
      call append(3, '- Post-update hook for '. name .' ... ')
      let error = ''
      let type = type(spec.do)
      if type == s:TYPE.string
        if spec.do[0] == ':'
          if !get(s:loaded, name, 0)
            let s:loaded[name] = 1
            call s:reorg_rtp()
          endif
          call s:load_plugin(spec)
          try
            execute spec.do[1:]
          catch
            let error = v:exception
          endtry
          if !s:plug_window_exists()
            cd -
            throw 'Warning: vim-plug was terminated by the post-update hook of '.name
          endif
        else
          let error = s:bang(spec.do)
        endif
      elseif type == s:TYPE.funcref
        try
          call s:load_plugin(spec)
          let status = installed ? 'installed' : (updated ? 'updated' : 'unchanged')
          call spec.do({ 'name': name, 'status': status, 'force': a:force })
        catch
          let error = v:exception
        endtry
      else
        let error = 'Invalid hook type'
      endif
      call s:switch_in()
      call setline(4, empty(error) ? (getline(4) . 'OK')
                                 \ : ('x' . getline(4)[1:] . error))
      if !empty(error)
        call add(s:update.errors, name)
        call s:regress_bar()
      endif
      cd -
    endif
  endfor
endfunction

function! s:hash_match(a, b)
  return stridx(a:a, a:b) == 0 || stridx(a:b, a:a) == 0
endfunction

function! s:checkout(spec)
  let sha = a:spec.commit
  let output = s:git_revision(a:spec.dir)
  if !empty(output) && !s:hash_match(sha, s:lines(output)[0])
    let credential_helper = s:git_version_requirement(2) ? '-c credential.helper= ' : ''
    let output = s:system(
          \ 'git '.credential_helper.'fetch --depth 999999 && git checkout '.plug#shellescape(sha).' --', a:spec.dir)
  endif
  return output
endfunction

function! s:finish(pull)
  let new_frozen = len(filter(keys(s:update.new), 'g:plugs[v:val].frozen'))
  if new_frozen
    let s = new_frozen > 1 ? 's' : ''
    call append(3, printf('- Installed %d frozen plugin%s', new_frozen, s))
  endif
  call append(3, '- Finishing ... ') | 4
  redraw
  call plug#helptags()
  call plug#end()
  call setline(4, getline(4) . 'Done!')
  redraw
  let msgs = []
  if !empty(s:update.errors)
    call add(msgs, "Press 'R' to retry.")
  endif
  if a:pull && len(s:update.new) < len(filter(getline(5, '$'),
                \ "v:val =