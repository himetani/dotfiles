export DOTPATH=~/git/dotfiles
export PATH="${DOTPATH}/bin:${PATH}"
export EDITOR="vim"

# Company specific config
if [ -e ~/company ];then
	for f (~/company/*.zsh) source "${f}"
fi

for f ($DOTPATH/**/*.zsh) source "${f}"

# dircolors
export LSCOLORS=exgxcxdxbxegedabagacad

PROMPT="[%n %~] \$vcs_info_msg_0_ %% "

# alias
alias ls='ls -G'
alias grep='grep -d skip'
alias t='vim ~/Text/inbox.md'
alias run='./run.sh'
alias sed='gsed'
alias tmux="TERM=screen-256color-bce tmux"
alias gd="godoc -http :6060"

# 履歴ファイルの保存先
export HISTFILE=${HOME}/.zsh_history
# メモリに保存される履歴の件数
export HISTSIZE=1000
# 履歴ファイルに保存される履歴の件数
export SAVEHIST=1000
# 重複を記録しない
setopt hist_ignore_dups
# 開始と終了を記録
setopt EXTENDED_HISTORY

function history-all { history -E 1 }

export GOPATH=$HOME/dev
export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin

autoload -Uz compinit && compinit
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook vcs_info
add-zsh-hook chpwd chpwd_recent_dirs

zstyle ':completion:*:*:cdr:*:*' menu selection
zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-pushd true
zstyle ':vcs_info:git:*' formats '%b'

precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
precmd_vcs_info() { vcs_info }

function _ssh {
  compadd `fgrep 'Host ' ~/.ssh/config | awk '{print $2}' | sort`;
}

export PKG_CONFIG_PATH=$HOME/.pkgconfig

if [ -n $TMUX ]; then
   alias vim="TERM=screen-256color vim"
fi

export GIT_EDITOR=vim

export CONFIGCTL_TEST_PRIVATE_KEY=$HOME/sandbox/configctl/.vagrant/machines/default/virtualbox/private_key

eval "$(direnv hook zsh)"

bindkey "^P" up-line-or-history
bindkey "^N" down-line-or-history
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^B" backward-char
bindkey "^F" forward-char
bindkey "^D" backward-delete-char

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
