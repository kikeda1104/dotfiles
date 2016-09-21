"autocmd BufWritePre * :%s/\s\+$//ge
"function! s:remove_dust()
"  let cursor = getpos(".")
"    " 保存時に行末の空白を除去する
"    %s/\s\+$//ge
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

"colorscheme railscasts

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

inoremap <silent> jj <ESC>

" ヘルプ日本語から英語
set helplang=ja,en

if dein#tap('syntastic')
let g:syntastic_enable_signs=1
let g:syntastic_mode_map = { 'mode': 'possive' }
let g:syntastic_ruby_checkers = ['rubocop']
augroup AutoSyntastic
    autocmd!
    execute 'autocmd InsertLeave,TextChanged * call s:syntastic()'
augroup END
function! s:syntastic() abort
    w
    SyntasticCheck
endfunction

execute 'autocmd AutoSyntastic User' 'dein#source' . g:dein#name
     \ 'call s:syntastic()'
endif

cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
