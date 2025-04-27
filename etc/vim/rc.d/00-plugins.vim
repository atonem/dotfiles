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
" let g:genereate_tmuxline = ':Tmuxline lightline | :TmuxlineSnapshot ~/.tmux/theme.conf'

" base
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'klen/nvim-config-local'

" colors
Plug 'guns/xterm-color-table.vim'

" Plug 'tpope/vim-vinegar'
Plug 'kdheepak/tabline.nvim'
" Plug 'edkolev/tmuxline.vim', { 'do': g:genereate_tmuxline }

" git

" lsp
Plug 'folke/lsp-colors.nvim'

" issues
" Plug 'folke/trouble.nvim'

" completion
"Plug 'hrsh7th/cmp-nvim-lsp'
"Plug 'hrsh7th/cmp-buffer'
"Plug 'hrsh7th/cmp-path'
"Plug 'hrsh7th/cmp-cmdline'
"Plug 'hrsh7th/nvim-cmp'

" snippets
" follow latest release and install jsregexp.
Plug 'L3MON4D3/LuaSnip', {'tag': 'v1.*', 'do': 'make install_jsregexp'}

" lang
Plug 'tmux-plugins/vim-tmux'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'vmchale/just-vim'
Plug 'digitaltoad/vim-pug'


" edit
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'matze/vim-move'

" tmux
Plug 'tmux-plugins/vim-tmux-focus-events'

" wiki
" Plug 'vimwiki/vimwiki'

call plug#end()
endif
