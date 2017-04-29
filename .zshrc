typeset -U path cdpath fpath manpath
export ZPLUG_HOME=/usr/local/opt/zplug
PATH=$PATH:$HOME/
PATH=~/Qt5.5.1/5.5/clang_64/bin:$PATH
#
##export LD_LIBRARY_PATH=$HOME/lib
#export USERNAME BASH_ENV PATH GEM_HOME GEM_PATH

#alias g='git'
#alias gst='g status'
#alias gco='g checkout'
#alias gci='g commit'
#alias gdi='g diff'
#alias gbr='g branch'
alias be='bundle exec'
#alias r='rails'
alias l='ls -l'
alias ct='ctags -R --languages=Ruby -f ~/ruby.tags `pwd`'

PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"
export PGHOST=localhost

## コマンドのオプションを強力に補完
autoload -U compinit
compinit -u
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

fpath=(/usr/local/share/zsh-completions $fpath)

# キーバインドをviに変更
set -o vi

bindkey -e


# http://qiita.com/b4b4r07/items/f37aadef0b3f740e8c14
source $ZPLUG_HOME/init.zsh

zplug "mollifier/anyframe"
zplug "mollifier/cd-gitroot"
zplug "b4b4r07/enhancd", use:enhancd.sh
zplug "zsh-users/zsh-history-substring-search", hook-build:"__zsh_version 4.3"
zplug "zsh-users/zsh-syntax-highlighting", defer:3
zplug "zsh-users/zsh-completions"
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux
zplug "peco/peco", as:command, from:gh-r, use:"*amd64*"
zplug "b4b4r07/zsh-gomi", if:"which fzf"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

autoload -Uz anyframe-init
anyframe-init
autoload -Uz cd-gitroot
alias cg='cd-gitroot'

bindkey '^xb' anyframe-widget-cdr
bindkey '^x^b' anyframe-widget-checkout-git-branch

bindkey '^xr' anyframe-widget-execute-history
bindkey '^x^r' anyframe-widget-execute-history

bindkey '^xi' anyframe-widget-put-history
bindkey '^x^i' anyframe-widget-put-history

bindkey '^xg' anyframe-widget-cd-ghq-repository
bindkey '^x^g' anyframe-widget-cd-ghq-repository

bindkey '^xk' anyframe-widget-kill
bindkey '^x^k' anyframe-widget-kill

bindkey '^xe' anyframe-widget-insert-git-branch
bindkey '^x^e' anyframe-widget-insert-git-branch

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey '^A' history-substring-search-up
