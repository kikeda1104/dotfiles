autocmd BufWritePre * :%s/\s\+$//ge

function! s:remove_dust()
    let cursor = getpos(".")
    " 保存時に行末の空白を除去する
    %s/\s\+$//ge
    " 保存時にtabを2スペースに変換する
    %s/\t/  /ge
    call setpos(".", cursor)
    unlet cursor
endfunction
autocmd BufWritePre * call <SID>remove_dust()

if &compatible
  set nocompatible               " Be iMproved
endif

set runtimepath^=~/.vim/repos/github.com/Shougo/dein.vim

 call dein#begin(expand('~/.cache/dein'))

 call dein#add('Shougo/dein.vim')
 call dein#add('Shougo/neocomplete.vim')
 call dein#add('tpope/vim-rails')
 call dein#add('tpope/vim-bundler')
 call dein#add('scrooloose/syntastic')
 call dein#add('vim-jp/vimdoc-ja')
 call dein#add('jpo/vim-railscasts-theme')

 call dein#end()

 filetype plugin indent on

set clipboard=unnamedplus,autoselect

set number
set nocompatible
syntax on
set autoindent
set tabstop=2
set expandtab
set softtabstop=2
set shiftwidth=2

colorscheme railscasts

inoremap <silent> jj <ESC>

" ヘルプ日本語から英語
set helplang=ja,en

let g:syntastic_mode_map = { 'mode': 'active',
            \ 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']
