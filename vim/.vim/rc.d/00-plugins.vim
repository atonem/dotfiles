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
Plug 'liuchengxu/vista.vim'

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'


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
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'ekalinin/Dockerfile.vim'
Plug 'uber/prototool', { 'rtp':'vim/prototool' }
Plug 'SirVer/ultisnips'
Plug 'psf/black'
Plug 'rust-lang/rust.vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'vmchale/just-vim'
Plug 'cespare/vim-toml'
Plug 'memgraph/cypher.vim'
Plug 'digitaltoad/vim-pug'
Plug 'epitzer/vim-rdf-turtle'


" edit
Plug 'editorconfig/editorconfig-vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'matze/vim-move'
" Plug 'ludovicchabant/vim-gutentags'

" lint
Plug 'w0rp/ale'

" tmux
Plug 'tmux-plugins/vim-tmux-focus-events'

" test
Plug 'janko/vim-test'

" accounting
Plug 'ledger/vim-ledger'

" util
Plug 'dstein64/vim-startuptime'

call plug#end()
endif
