" inspired by https://github.com/junegunn/dotfiles/blob/master/vimrc

let s:darwin = has('mac')
let home_dir = $HOME

silent! if plug#begin('~/.vim/plugged')

if s:darwin
  " let g:plug_url_format = 'git@github.com:%s.git'
else
  let $GIT_SSL_NO_VERIFY = 'true'
endif

" Need to use vimscript expression b/c two commands run
let g:genereate_tmuxline = ':Tmuxline lightline | :TmuxlineSnapshot ~/.tmux/theme.conf'

" colors
Plug 'tomasr/molokai'

" gui
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-vinegar'
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim', { 'do': g:genereate_tmuxline }
Plug 'edkolev/promptline.vim', { 'do': ':PromptlineSnapshot ~/.zsh/.promptline_theme lightline' }


" git
Plug 'airblade/vim-gitgutter'

" lang
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'hail2u/vim-css3-syntax'
Plug 'cakebaker/scss-syntax.vim'
Plug 'ap/vim-css-color'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'mustache/vim-mustache-handlebars'
Plug 'jparise/vim-graphql'
Plug 'posva/vim-vue'
Plug 'dart-lang/dart-vim-plugin'
Plug 'tmux-plugins/vim-tmux'

" edit
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-commentary'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" lint
Plug 'w0rp/ale'

" tmux
Plug 'tmux-plugins/vim-tmux-focus-events'

" Plug ''
" Plug ''
" Plug ''
" Plug ''
" Plug ''
" Plug ''

call plug#end()
endif
