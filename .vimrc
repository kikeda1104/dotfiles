set nocompatible
"set directory=~/.vim/tmp
set noswapfile
set undodir=~/.vim/backup
set backupdir=~/.vim/backup
set shiftwidth=2
set softtabstop=0
set expandtab
set title
set clipboard=unnamed,autoselect
" モードラインを有効にする
set modeline


" 3行目までをモードラインとして検索する
set modelines=3

if has('vim_starting')
              execute 'set runtimepath+=' . expand('~/.vim/bundle/neobundle.vim')
      endif
      call neobundle#rc(expand('~/.vim/bundle'))

      NeoBundle 'git://github.com/Shougo/neobundle.vim.git'
      NeoBundle 'git://github.com/scrooloose/nerdtree.git'
      NeoBundle 'git://github.com/tpope/vim-rails.git'
      NeoBundle 'git://github.com/tyru/open-browser.vim.git'
      NeoBundle 'git://github.com/pangloss/vim-javascript.git'
      NeoBundle 'git://github.com/kchmck/vim-coffee-script.git'
      NeoBundle 'git://github.com/thoughtbot/vim-rspec.git'
      NeoBundle 'git://github.com/ujihisa/unite-gem.git'
      NeoBundle 'git://github.com/tpope/vim-haml.git'
      NeoBundle 'git://github.com/LeafCage/yankround.vim.git'
      NeoBundle 'git://github.com/tpope/vim-fugitive.git'
      NeoBundle 'Shougo/neosnippet'
      NeoBundle 'Shougo/neosnippet-snippets'
      NeoBundle 'yaasita/ore_markdown', {
      \ 'build' : {
      \     'windows' : 'bundle install --gemfile .\bin\Gemfile',
      \     'mac' : 'bundle install --gemfile ./bin/Gemfile',
      \     'unix' : 'bundle install --gemfile ./bin/Gemfile'
      \    },
      \ }
      NeoBundle 'othree/html5.vim'
      NeoBundle 'vim-jp/vimdoc-ja'
      NeoBundle 'https://github.com/tell-k/vim-browsereload-mac.git'
      NeoBundle 'https://github.com/koron/codic-vim.git'


NeoBundleLazy 'Shougo/unite.vim', {
      \   'autoload' : {
      \       'commands' : [ "Unite", "UniteWithBufferDir", "UniteWithCurrentDir" ]
      \   }
      \}

NeoBundleCheck

      filetype plugin indent on
      syntax on

      " SSH クライアントの設定によってはマウスが使える（putty
      " だと最初からいける）
      set mouse=n
" 編集中のファイルのディレクトリに移動
noremap ,d :execute ":lcd" . expand("%:p:h")<CR>

if has("autocmd")
            autocmd BufReadPost *
                \ if line("'\"") > 0 && line ("'\"") <= line("$") |
                \   exe "normal! g'\"" |
                \ endif
    endif
" 行番号を表示
set number
" color scheme
colorscheme railscasts

" Tabをスペースに置き換える
set tabstop=2
"set autoindent
set expandtab
set shiftwidth=2

" カーソル行をハイライト
set cursorline
" " カレントウィンドウにのみ罫線を引く
augroup cch
autocmd! cch
autocmd WinLeave * set nocursorline
autocmd WinEnter,BufRead * set cursorline
augroup END
"
:hi clear CursorLine
:hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black

augroup MyAutoCmdFileType
autocmd! MyAutoCmdFileType

" ウィンドウサイズの指定
"set columns=130
"set lines=80
"set autoread

nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
nmap map-you-like <Plug>(openbrowser-search) 

let g:vim_tags_project_tags_command = "/opt/local/bin/ctags -R {OPTIONS} {DIRECTORY} 2>/dev/null"
let g:vim_tags_gem_tags_command = "/opt/local/bin/ctags -R {OPTIONS} `bundle show --paths` 2>/dev/null"

autocmd BufNewFile, BufRead *.text set spell
autocmd BufNewFile, BufRead *.md set spell

command Nt NERDTree

set backspace=indent,eol,start

"Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

let g:neosnippet#enable_snipmate_compatibility = 1
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/snippets'
" let g:neosnippet#snippets_directory=[ expand("~")."/.vim/snippets" ]

" vim: foldmethod=marker
" vim" foldcolumn=3
" vim" foldlevel=0

let g:unite_enable_start_insert=1

set completefunc=GoogleComplete
 
function! GoogleComplete(findstart, base)
  if a:findstart
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && line[start - 1] =~ '\S'
      let start -= 1
    endwhile
    return start
  else
    let ret = system('curl -s -G --data-urlencode "q='
    \ . a:base . '" "http://suggestqueries.google.com/complete/search?&client=firefox&hl=ja&ie=utf8&oe=utf8"')
    let res = split(substitute(ret,'\[\|\]\|"',"","g"),",")
    return res
  endif
endfunction

vnoremap ' di'<C-R>"'<ESC>
inoremap <silent> jj <ESC>
set showcmd

" tab機能

" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}

let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ

command! -nargs=? Eiwa call Goo("ej",<f-args>)
command! -nargs=? Kokugo call Goo("jn",<f-args>)
command! -nargs=? Waei call Goo("je",<f-args>)
command! -nargs=? Ruigo call Goo("thsrs",<f-args>)

function! Goo(jisyo,...) "{{{2
  if has('win32') || has('gui_running')
    let l:cmd = "!"
  else
    let l:cmd = "!clear && "
  endif
  if a:0 == 0
    let l:search_word = expand("<cword>")
  else
    let l:search_word = a:1
  endif

  if a:jisyo == "ej"
    let l:search_tag = " | perl -nle 'print if /alllist/i../<\\/dl>/ or /prog_meaning/'"
  elseif a:jisyo == "je"
    let l:search_tag = " | perl -nle 'print if /alllist/i../<\\/dl>/ or /prog_meaning|prog_example/' "
  elseif a:jisyo == "jn"
    let l:search_tag = " | perl -nle 'print if /alllist/i../<\\/dl>/ or /meaning/' "
  elseif a:jisyo == "thsrs"
    let l:search_tag = " | perl -nle 'print if /--wordDefinition/i../--\\/wordDefinition/'"
  endif

  execute l:cmd . "curl -s -L " .
  \ "http://dictionary.goo.ne.jp/srch/" . a:jisyo . "/" .
  \ "$(echo " . l:search_word . " | nkf -wMQ | tr = \\%)" .
  \ "/m1u/ " .
  \ l:search_tag .
  \ " | perl -ple 's/<.+?>//g'"
  \ " | head -50"

endfunction "}}}

nnoremap sp :Unite neosnippet<CR>


