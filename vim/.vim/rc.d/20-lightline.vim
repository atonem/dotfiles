" configuration of lightline, tmuxline, and promptline
" let g:lightline = {
      " \'colorscheme': 'molokai' }
" zsh prompt generation
let g:promptline_preset = {
      \'a'    : [ '%n' ],
      \'b'    : [ '%~' ],
      \'c'    : [ promptline#slices#python_virtualenv() ],
      \'x'    : [ ' ' ],
      \'warn' : [ promptline#slices#last_exit_code()],
      \'y'    :  [ promptline#slices#vcs_branch() ],
      \'z' : [ '' ]}

" tmux configuration
let g:tmuxline_preset = 'powerline'
" TODO: customize with battery preset
" add tmux tmux/.tmux/plugins/tpm and tmux-battery
" let g:tmuxline_preset = {
"       \'a'    : '#S',
"       \'b'    : '#W',
"       \'c'    : '#H',
"       \'win'  : '#I',
"       \'cwin' : '#W',
"       \'x'    : '#{battery_icon}#{battery_percentage}',
"       \'y'    : '%Y-%m-%d  %H:%M',
"       \'z'    : '#h'}
