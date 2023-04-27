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

" git
Plug 'lewis6991/gitsigns.nvim'
Plug 'ruifm/gitlinker.nvim'

" highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'folke/lsp-colors.nvim'

" issues
Plug 'folke/todo-comments.nvim'

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
Plug 'vmchale/just-vim'
Plug 'digitaltoad/vim-pug'


" edit
Plug 'editorconfig/editorconfig-vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'matze/vim-move'

" tmux
Plug 'tmux-plugins/vim-tmux-focus-events'

" util
Plug 'dstein64/vim-startuptime'

" wiki
" Plug 'vimwiki/vimwiki'

call plug#end()
endif
