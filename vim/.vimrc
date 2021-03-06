" auto-install vim-plug
if !has('nvim') && empty(glob('$HOME/.vim/autoload/plug.vim'))
  silent !curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup vim-plug-install
    autocmd VimEnter * PlugInstall
  augroup END
endif

" ==================================================
" Allow pre-definitions via ~/.vim/before.vim
" ==================================================
if filereadable(expand("~/.vim/before.vim"))
    source ~/.vim/before.vim
endif

" ==================================================
" Source the files ~/.vim/rc.d/
" ==================================================
for f in split(glob('~/.vim/rc.d/*.vim'), '\n')
    exe 'source' f
endfor

" ==================================================
" Allow overrides via ~/.vim/after.vim
" ==================================================
if filereadable(expand("~/.vim/after.vim"))
    source ~/.vim/after.vim
endif


" ==================================================
" Local customization in ~/.vimrc_local
" ==================================================
let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif
