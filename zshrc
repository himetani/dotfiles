# ============================================================================
# Environent variables
# ============================================================================

export DOTPATH=$HOME/git/dotfiles
export EDITOR="nvim"
export FZFPATH=$HOME/.fzf
export GOPATH=`go env GOPATH`
export GOBIN="${GOPATH}/bin"
export PATH="${HOME}/.private/bin:${HOME}/company/bin:/usr/local/bin:${FZFPATH}/bin:${DOTPATH}/bin:${GOBIN}:${PATH}"
export GO111MODULE=on

export PKG_CONFIG_PATH=$HOME/.pkgconfig

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# ============================================================================
# alias
# ============================================================================

alias ls='ls -G'
alias grep='grep -d skip'
alias t='nvim ~/Documents/inbox.md'
alias sed='gsed'
alias gst="git status"
alias gl="git log"
alias gb="git branch"
alias gd="git diff"
alias dco="docker-compose"

# ============================================================================
# history
# ============================================================================

export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000
setopt hist_ignore_dups
setopt EXTENDED_HISTORY
function history-all { history -E 1 }

# ============================================================================
# zsh util
# ============================================================================

autoload -Uz compinit && compinit
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook vcs_info
add-zsh-hook chpwd chpwd_recent_dirs

zstyle ':completion:*:*:cdr:*:*' menu selection
zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-pushd true

setopt no_beep

function _ssh {
  compadd `fgrep 'Host ' ~/.ssh/config | awk '{print $2}' | sort`;
}

# ============================================================================
# bindkey
# ============================================================================

bindkey "^P" up-line-or-history
bindkey "^N" down-line-or-history
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^B" backward-char
bindkey "^F" forward-char
bindkey "^D" delete-char-or-list

# ============================================================================
# Load func
# ============================================================================

if [ -e ~/company ];then
  for f (~/company/*.zsh) source "${f}"
fi

eval "$(direnv hook zsh)"

# kubectl completion
source <(kubectl completion zsh)
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source $HOME/.cargo/env
eval "$(starship init zsh)"

for f ($HOME/git/dotfiles/zsh/*.zsh) source "${f}"
