set nocompatible
"set directory=~/.vim/tmp
set noswapfile
set backupdir=~/.vim/backup
set shiftwidth=2
set softtabstop=0
set expandtab
set title
set clipboard=unnamed,autoselect

if has('vim_starting')
              execute 'set runtimepath+=' . expand('~/.vim/bundle/neobundle.vim')
      endif
      call neobundle#rc(expand('~/.vim/bundle'))

NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
  \     'windows' : 'make -f make_mingw32.mak',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'unix' : 'make -f make_unix.mak',
  \    },
  \ }

      NeoBundle 'git://github.com/kien/ctrlp.vim.git'
      NeoBundle 'git://github.com/Shougo/neobundle.vim.git'
      NeoBundle 'git://github.com/scrooloose/nerdtree.git'
      NeoBundle 'git://github.com/scrooloose/syntastic.git'
      NeoBundle 'git://github.com/Shougo/vimshell.vim.git'
      NeoBundle 'git://github.com/tpope/vim-rails.git'
      NeoBundle 'git://github.com/vim-scripts/grep.vim.git'
      NeoBundle 'git://github.com/vim-scripts/sudo.vim.git'
      NeoBundle 'git://github.com/vim-ruby/vim-ruby.git'
      NeoBundle 'git://github.com/tyru/open-browser.vim.git'
      NeoBundle 'git://github.com/tpope/vim-cucumber.git'
      NeoBundle 'git://github.com/pangloss/vim-javascript.git'
      NeoBundle 'git://github.com/joker1007/vim-ruby-heredoc-syntax.git'
      NeoBundle 'git://github.com/kchmck/vim-coffee-script.git'
      NeoBundle 'git://github.com/thoughtbot/vim-rspec.git'
      NeoBundle 'git://github.com/Shougo/neocomplcache.vim.git'
      NeoBundle 'git://github.com/vim-scripts/SingleCompile.git'
      NeoBundle 'git://github.com/jceb/vim-hier.git'
      NeoBundle 'git://github.com/h1mesuke/unite-outline.git'
      NeoBundle 'git://github.com/Rip-Rip/clang_complete.git'
      NeoBundle 'git://github.com/szw/vim-tags.git'
      NeoBundle 'git://github.com/ujihisa/unite-gem.git'
      NeoBundle 'git://github.com/rhysd/unite-ruby-require.vim.git'
      NeoBundle 'git://github.com/tpope/vim-haml.git'
      NeoBundle 'git://github.com/joker1007/unite-pull-request'
      NeoBundle 'git://github.com/LeafCage/yankround.vim.git'
      NeoBundle 'git://github.com/vim-scripts/dbext.vim.git'
      NeoBundle 'git://github.com/othree/javascript-libraries-syntax.vim'
      NeoBundle 'git://github.com/tpope/vim-fugitive.git'
      NeoBundle 'Shougo/neocomplcache'
      NeoBundle 'yaasita/ore_markdown', {
            \ 'build' : {
            \     'windows' : 'bundle install --gemfile .\bin\Gemfile',
            \     'mac' : 'bundle install --gemfile ./bin/Gemfile',
            \     'unix' : 'bundle install --gemfile ./bin/Gemfile'
            \    },
            \ }
      NeoBundle 'jistr/vim-nerdtree-tabs'
          let g:nerdtree_tabs_open_on_console_startup=1

NeoBundleLazy 'alpaca-tc/neorspec.vim', {
    \ 'depends' : 'tpope/vim-rails',
    \ 'autoload' : {
    \   'commands' : [
    \       'RSpecAll', 'RSpecNearest', 'RSpecRetry',
    \       'RSpecCurrent', 'RSpec'
    \ ] }}
NeoBundleLazy 'tpope/vim-dispatch', { 'autoload' : {
      \ 'commands' : ['Dispatch', 'FocusDispatch', 'Start']
      \ }}

NeoBundleLazy 'Shougo/unite.vim', {
      \   'autoload' : {
      \       'commands' : [ "Unite", "UniteWithBufferDir", "UniteWithCurrentDir" ]
      \   }
      \}

NeoBundleLazy 'Shougo/neosnippet'

NeoBundleLazy 'Shougo/vimshell', {
      \ 'depends' : 'Shougo/vimproc',
      \ 'autoload' : {
      \   'commands' : [{ 'name' : 'VimShell',
      \                   'complete' : 'customlist,vimshell#complete'},
      \                 'VimShellExecute', 'VimShellInteractive',
      \                 'VimShellTerminal', 'VimShellPop'],
      \   'mappings' : ['<Plug>(vimshell_switch)']
      \ }}

NeoBundleCheck
      filetype plugin on
      filetype indent on
      syntax on


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
autocmd BufRead,BufNewFile *.scala set filetype=scala

" ウィンドウサイズの指定
"set columns=130
"set lines=80
"set autoread

let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
nmap map-you-like <Plug>(openbrowser-search) 

NeoBundleLazy 'Shougo/vimshell', {
      \ 'depends' : 'Shougo/vimproc',
      \ 'autoload' : {
      \   'commands' : [{ 'name' : 'VimShell',
      \                   'complete' : 'customlist,vimshell#complete'},
      \                 'VimShellExecute', 'VimShellInteractive',
      \                 'VimShellTerminal', 'VimShellPop'],
      \   'mappings' : ['<Plug>(vimshell_switch)']
      \ }}


let g:vim_tags_project_tags_command = "/opt/local/bin/ctags -R {OPTIONS} {DIRECTORY} 2>/dev/null"
let g:vim_tags_gem_tags_command = "/opt/local/bin/ctags -R {OPTIONS} `bundle show --paths` 2>/dev/null"

" vimshell {{{
nnoremap <silent>, vs :<C-U>VimShell<CR>
 
"let s:bundle = neobundle#get("vimshell")
"MyAutocmd FileType vimshell
" \ call vimshell#altercmd#define('g','git')
" \| call vimshell#altercmd#define('l','ll')
" \| call vimshell#altercmd#define('ll','ls -l')
" \| call vimshell#altercmd#define('be','bundle exec')
" \| call vimshell#altercmd#define('ra','rails')
" \| call vimshell#hook#add('chpwd','my_chpwd', 'g:my_chpwd')
"unlet s:bundle
" }}}

" <TAB>: completion.                                         
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"   
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>" 

" Plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal') 
  set conceallevel=2 concealcursor=i
endif

autocmd BufNewFile, BufRead *.text set spell
autocmd BufNewFile, BufRead *.md set spell

command Vs VimShell 
command Nt NERDTree
command Rc Rcontroller
command Rm Rmodel
command Rv Rview

set backspace=indent,eol,start


"MyNERDTreeで開く
"固定したいWindowを選択してMyNERDTreeWindowLockでロック
"MyNERDTreeWindowUnLockで解除
"あとは普通にEnterで開けばロックしたWindowは避けるはず
command! -nargs=0 MyNERDTree NERDTreeToggle | call SetMyNERD()
command! -nargs=0 MyNERDTreeWindowLock let w:lock_window = 1
command! -nargs=0 MyNERDTreeWindowUnLock let w:lock_window = 0
function! SetMyNERD()
  nnoremap <buffer> <ENTER> :call MyNERDTreeOpenFile()<CR>
endfunction

function! MyNERDTreeOpenFile()
  wincmd p
  if !exists('w:lock_window')
    let w:lock_window = 0
  endif
  let l:lock = w:lock_window
  wincmd p
  let node = g:NERDTreeFileNode.GetSelected()
  if l:lock && !node.path.isDirectory
    call nerdtree#invokeKeyMap("i")
  else
    call nerdtree#invokeKeyMap("o")
  endif
endfunction
