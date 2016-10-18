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

set runtimepath+=/Users/ikeda_kazuyuki/.vim/dein/repos/github.com/Shougo/dein.vim
  call dein#begin(expand('~/.cache/dein'))
    call dein#add('Shougo/dein.vim')
    call dein#load_toml('~/.vim/rc/dein.toml', {'lazy': 0})
  call dein#end()

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline=%t       "tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set foldmethod=syntax

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = '❗'
let g:syntastic_style_error_symbol = '❗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_warning_symbol = '⚠'

let g:syntastic_mode_map = { 'mode': 'active',
            \ 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']

if has('nvim')
  set clipboard=unnamedplus
else
  set clipboard=unnamedplus,autoselect
endif

set noswapfile
set undodir=~/.vim/backup
set backupdir=~/.vim/backup

set title
set number
syntax on
set cursorline
set incsearch
set ignorecase
set smartcase
set hlsearch

" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>
set showcmd
set modelines=3

set expandtab
set tabstop=2
set softtabstop=4
set shiftwidth=2
set autoindent
set breakindent

set showmatch

set wildmenu
set history=5000

" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

colorscheme railscasts
set t_Co=256

set showtabline=2 " 常にタブラインを表示

inoremap <silent> jj <ESC>

set helplang=ja,en

" 編集中のファイルのディレクトリに移動
noremap ,d :execute ":lcd" . expand("%:p:h")<CR>

au BufNewFile,BufRead *.tag setlocal ft=javascript

" " カレントウィンドウにのみ罫線を引く
augroup cch
autocmd! cch
autocmd WinLeave * set nocursorline
autocmd WinEnter,BufRead * set cursorline
augroup END

highlight CursorLine ctermbg=black guibg=black

command! Evim e $MYVIMRC
nnoremap evim :vs $MYVIMRC<CR>
set backspace=indent,eol,start

augroup source-vimrc
  autocmd!
  autocmd BufWritePost *vimrc source $MYVIMRC | set foldmethod=marker
augroup END

augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead *.js setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.tag setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup end

"----------------------------------------
" vim-ref
"----------------------------------------
"{{{
let g:ref_open                    = 'vsplit'
let g:ref_refe_cmd                = 'rurema'
let g:ref_refe_version = 2

nnoremap rr :<C-U>Unite ref/refe     -default-action=split -input=
nnoremap ri :<C-U>Unite ref/ri       -default-action=split -input=

"バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>

nnoremap <silent> use :NeoSnippetEdit<CR>

imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>

aug MyAutoCmd
  au FileType ruby,eruby,ruby.rspec nnoremap <silent><buffer>KK :<C-U>Unite -no-start-insert ref/ri   -input=<C-R><C-W><CR>
  au FileType ruby,eruby,ruby.rspec nnoremap <silent><buffer>K  :<C-U>Unite -no-start-insert ref/refe -input=<C-R><C-W><CR>
aug END
"}}}

if !exists('loaded_matchit')
  " matchitを有効化
  runtime $VIMRUNTIME/macros/matchit.vim
endif

" 拡張子で読み込みタグ変更
au BufNewFile,BufRead *.rb set tags+=$HOME/ruby.tags
" ctags --languages=ruby -f ~/ruby.tags `pwd`
set re=1

filetype plugin on
"ファイルタイプに合わせたインデントを利用
filetype indent on
"sw=softtabstop, sts=shiftwidth, ts=tabstop, et=expandtabの略
autocmd FileType c           setlocal sw=2 sts=2 ts=2 et
autocmd FileType html        setlocal sw=2 sts=2 ts=2 et
autocmd FileType ruby        setlocal sw=2 sts=2 ts=2 et
autocmd FileType js          setlocal sw=2 sts=2 ts=2 et
autocmd FileType zsh         setlocal sw=2 sts=2 ts=2 et
autocmd FileType python      setlocal sw=2 sts=2 ts=2 et
autocmd FileType scala       setlocal sw=2 sts=2 ts=2 et
autocmd FileType json        setlocal sw=2 sts=2 ts=2 et
autocmd FileType html        setlocal sw=2 sts=2 ts=2 et
autocmd FileType css         setlocal sw=2 sts=2 ts=2 et
autocmd FileType scss        setlocal sw=2 sts=2 ts=2 et
autocmd FileType sass        setlocal sw=2 sts=2 ts=2 et
autocmd FileType javascript  setlocal sw=2 sts=2 ts=2 et

imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
let g:neosnippet#snippets_directory = '~/.vim/snippets/'

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
