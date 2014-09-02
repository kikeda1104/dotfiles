
PATH=$PATH:$HOME/
export PATH="/usr/local/heroku/bin:$PATH"
export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
#export CC=/opt/local/bin/i686-apple-darwin13-gcc-apple-4.2.1
#export CXX=/opt/local/bin/i686-apple-darwin13-g++-apple-4.2.1
#export CPP=/opt/local/bin/i686-apple-darwin13-gpp-apple-4.2.1
#
##export LD_LIBRARY_PATH=$HOME/lib
#export USERNAME BASH_ENV PATH GEM_HOME GEM_PATH

alias vi='env LANG=ja_JP.UTF-8 /opt/local/bin/vim'
alias vim='env LANG=ja_JP.UTF-8 /opt/local/bin/vim'
#alias g='git'
#alias gst='g status'
#alias gco='g checkout'
#alias gci='g commit'
#alias gdi='g diff'
#alias gbr='g branch'
alias be='bundle exec'
#alias r='rails'
alias l='ls -l'

PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"

PATH="$HOME/node_modules/coffee-script/bin:$PATH"
PATH="/opt/local/bin:$PATH"
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH=/Users/Kikeda/adt-bundle-mac-x86_64-20131030/sdk/platform-tools:$PATH
export PGHOST=localhost
##
## Your previous /Users/Kikeda/.bash_profile file was backed up as /Users/Kikeda/.bash_profile.macports-saved_2013-07-08_at_01:54:22
###
#
## MacPorts Installer addition on 2013-07-08_at_01:54:22: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
## Finished adapting your PATH environment variable

## zshrc

## コマンドのオプションを強力に補完
autoload -U compinit
compinit
zstyle ':completion:*:default' menu select=2

# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

export ZLS_COLORS=$LS_COLORS
# lsコマンド時、自動で色がつく(ls -Gのようなもの？)
export CLICOLOR=true
# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

### Prompt ###
# プロンプトに色を付ける
autoload -U colors; colors

 ##historyの設定
# historyを保存するファイル
HISTFILE=~/.zsh/.zsh_history
# 大きな数を指定してhistoryを残す
HISTSIZE=10000000
# 保存するhistory数
SAVEHIST=$HISTSIZE
# コマンドラインだけではなく実行時刻と実行時間も保存する
setopt extended_history
# 複数のzshを同時に使う時などhistoryファイルに上書きせず追加する
setopt append_history
# 同じコマンドラインを連続で実行した場合は登録しない
setopt hist_ignore_dups
# スペースで始まるコマンドラインは追加しない
setopt hist_ignore_space
# すぐにhistoryファイルに追記する
setopt inc_append_history
# zshプロセス間でhistoryを共有する
setopt share_history
# historyコマンドを記録しない
setopt hist_no_store
# 余分なスペースを削除して記録する
setopt hist_reduce_blanks

# C-s C-qを無効
setopt no_flow_control

# ディレクトリ名だけでディレクトリへ移動
setopt auto_cd

# 補完候補が複数ある時に一覧を表示する
setopt auto_list

# 保管結果を詰める
setopt list_packed

# Tabで順に補完候補を自動で補完する
setopt auto_menu

# カッコなどを自動的に補完する
setopt auto_param_keys

# ディレクトリ名の補完で末尾のスラッシュを付加して次の補完に備える
setopt auto_param_slash

# ビープ音を鳴らさない
setopt no_beep
# 一般ユーザ時
tmp_prompt="%F{cyan}[%n@%D{%m/%d %T}]%f "
tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
tmp_rprompt="%{${fg[green]}%}[%~]%{${reset_color}%}"
tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"

# rootユーザ時(太字にし、アンダーバーをつける)
if [ ${UID} -eq 0 ]; then
  tmp_prompt="%B%U${tmp_prompt}%u%b"
  tmp_prompt2="%B%U${tmp_prompt2}%u%b"
  tmp_rprompt="%B%U${tmp_rprompt}%u%b"
  tmp_sprompt="%B%U${tmp_sprompt}%u%b"
fi

PROMPT=$tmp_prompt    # 通常のプロンプト
PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
RPROMPT=$tmp_rprompt  # 右側のプロンプト
SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト
# SSHログイン時のプロンプト
#[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
#  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
#;
precmd() {
  [[ -t 1 ]] || return
  case $TERM in
    *xterm*|rxvt|(dt|k|E)term)
      print -Pn "\e]2;[%~]\a"    
      ;;
      # screen)
      #      #print -Pn "\e]0;[%n@%m %~] [%l]\a"
      #      print -Pn "\e]0;[%n@%m %~]\a"
      #      ;;
  esac
}

fpath=(~/.zsh/completion $fpath)

autoload -U compinit
compinit -u

export LC_ALL=en_US.UTF-8

# キーバインドをviに変更
set -o vi
export PATH="$HOME:$PATH"
export PATH="$HOME/android-sdks/platform-tools:$PATH"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
export PATH="/opt/local/lib/python2.7/site-packages:$PATH"
export PYTHONPATH="/opt/local/lib/python2.7/site-packages"

