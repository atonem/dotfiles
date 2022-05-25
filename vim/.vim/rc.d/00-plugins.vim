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

" base
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'

" colors
Plug 'tomasr/molokai'

" gui
if has('nvim')
  Plug 'kyazdani42/nvim-web-devicons'
else
  Plug 'ryanoasis/vim-devicons'
endif
" Plug 'tpope/vim-vinegar'
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim', { 'do': g:genereate_tmuxline }
Plug 'liuchengxu/vista.vim'

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
" TO ADD
" https://github.com/tpope/vim-rhubarb
" Plug 'lewis6991/gitsigns.nvim'
" https://github.com/junegunn/gv.vim

" highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'folke/lsp-colors.nvim'

" telescope
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" defx
if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/defx.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'kristijanhusak/defx-git'
Plug 'kristijanhusak/defx-icons'


" completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" lang
Plug 'tmux-plugins/vim-tmux'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'uber/prototool', { 'rtp':'vim/prototool' }
Plug 'psf/black'
Plug 'vmchale/just-vim'
Plug 'memgraph/cypher.vim'
Plug 'digitaltoad/vim-pug'


" edit
Plug 'editorconfig/editorconfig-vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
" Plug '/opt/homebrew/opt/fzf'
" Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'matze/vim-move'
" Plug 'ludovicchabant/vim-gutentags'

" lint
" Plug 'w0rp/ale'

" tmux
Plug 'tmux-plugins/vim-tmux-focus-events'

" test
Plug 'janko/vim-test'

" util
Plug 'dstein64/vim-startuptime'

call plug#end()
endif
