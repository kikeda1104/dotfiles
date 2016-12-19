"autocmd BufWritePre * :%s/\s\+$//ge "function! s:remove_dust()
"  let cursor = getpos(".")

"    " 保存時にtabを2スペースに変換する
"    %s/\t/  /ge
"    call setpos(".", cursor)
"    unlet cursor
"endfunction
"autocmd BufWritePre * call <SID>remove_dust()
"

" dein本体
let s:dein_repo_dir = '~/.vim/repos/github.com/Shougo/dein.vim'
let s:dein_dir = '~/cache/dein'
let g:rc_dir = expand('~/.vim/rc')
let s:dein_toml = g:rc_dir . '/dein.toml'
let s:dein_lazy_toml = g:rc_dir . '/dein_lazy.toml'

if &compatible 
  set nocompatible               " Be iMproved endif
endif 

execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
" Required:
if dein#load_state(s:dein_dir)
  call dein#begin('~/cache/dein')
  call dein#load_toml(s:dein_toml, {'lazy': 0 })
  call dein#load_toml(s:dein_lazy_toml, {'lazy': 1 })
  call dein#end()
  call dein#save_state()
end 

if dein#check_install()
  call dein#install()
endif

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
set showmatch
source $VIMRUNTIME/macros/matchit.vim
set wildmenu
set history=5000 
set incsearch
set ignorecase
set smartcase
set hlsearch

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
set foldmethod=marker

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = '❗'
let g:syntastic_style_error_symbol = '❗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_warning_symbol = '⚠'

 let g:syntastic_mode_map = { 'mode': 'passive',
            \ 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']

nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

"colorscheme railscasts

inoremap <silent> jj <ESC>

nnoremap <silent>uff :Unite file<CR>
nnoremap <silent>ufr :Unite file_rec<CR>

" ヘルプ日本語から英語
set helplang=ja,en

cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>

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
"バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>

nnoremap <silent> use :NeoSnippetEdit<CR>

nnoremap <silent> ,ug  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>
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

nnoremap <S-k> i<CR>

if dein#tap('neosnippet')
" Plugin key-mappings.  " <C-k>でsnippetの展開
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
let g:neosnippet#snippets_directory = '~/.vim/snippets/'
endif

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

command! Rc :SyntasticCheck
nnoremap <silent> <C-c> :SyntasticCheck<CR>
