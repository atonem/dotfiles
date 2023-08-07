" ==================================================
" Basic Settings
" ==================================================
set cmdheight=2          " Make command line two lines high
set laststatus=2         " allways show status line
set scrolloff=3          " keep 3 lines when scrolling
set cursorline           " have a line indicate the cursor location
set cindent              " cindent
set autoindent           " always set autoindenting on
set showcmd              " display incomplete commands
set ruler                " show the cursor position all the time
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
set visualbell
set nobackup             " do not keep a backup file
set noswapfile           " do not keep a swap file
set title                " show title in console title bar
set ttyfast              " smoother changes
set modeline             " last lines in document sets vim mode
set shortmess=atI        " Abbreviate messages
set nostartofline        " don't jump to first character when paging
set backspace=indent,eol,start
set matchpairs+=<:>      " show matching <> (html mainly) as well
set noshowmode           " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set matchtime=3
set showmatch            " show matching braces, somewhat annoying...
set mouse=               " disable mouse
set history=1000         " larger history
set timeout ttimeoutlen=50
set lazyredraw           " Speed up scrolling etc.
set autowrite            " Automatically write on :make
set clipboard=unnamed    " Share clipboard with macos
set nocompatible

set splitright           " Splits to the right
autocmd VimResized * wincmd =   " Automatically equalize splits when Vim is resized

set wildmenu                    " show list instead of just completing
set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
" set completeopt=menu            " Just show the menu upon completion (faster)

set directory=~/tmp      " Keep swap files out of the working dir, Adjust if needed in another dir

syntax on
set synmaxcol=200        " Syntax highlight only the first 200 chars"
filetype plugin on
filetype indent plugin on

set colorcolumn=80

if has('linebreak')      " Break indent wrapped lines
  set breakindent
  let &showbreak = '↳ '
  set cpoptions+=n
end

" ==================================================
" Tab expanded to 2 spaces
" ==================================================
set tabstop=2            " numbers of spaces of tab character
set shiftwidth=2         " numbers of spaces to (auto)indent
set expandtab		         " Tab to spaces by default
set softtabstop=2

" ==================================================
" Search settings
" ==================================================
set hlsearch             " highlight searches
set incsearch            " do incremental searching
set ignorecase           " ignore case when searching
set infercase            " smarter completions that will be case aware when ignorecase is on
set smartcase            " if searching and search contains upper case, make case sensitive search


" ==================================================
" No modlines for security
" ==================================================
set modelines=1
" set nomodeline

" ==================================================
" Trailing whitespace handling
" ==================================================

" Highlight end of line whitespace.
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/


" ==================================================
" Python program where client is installed
" ==================================================

"let g:python3_host_prog = '/usr/local/bin/python'

" ==================================================
" Automatic toggling of relative line numbers
" ==================================================
"
:set number relativenumber

augroup numbertoggle
  autocmd! numbertoggle
  " Skip this on netrw so we don't get a ruler
  autocmd BufEnter,FocusGained,InsertLeave * if &filetype != "netrw" | set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * if &filetype != "netrw" | set norelativenumber
augroup END

" ==================================================
" netrw configuration
" ==================================================
"
let g:netrw_list_hide= '.swp$,.DS_Store,*/tmp/*,*.so,*.swp,*.zip,.git,^\.\.\=/\=$'
let g:netrw_liststyle=3
let g:netrw_bufsettings = 'noruler nonumber norelativenumber'

" ==================================================
" Clear search highlight when escape is pressed.
" Is really horrible on terminals.
" ==================================================
"
" nnoremap <esc> :noh<return><esc>

" Add fzf to runtime path
set runtimepath+=/usr/local/opt/fzf
