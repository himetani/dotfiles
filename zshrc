# ============================================================================
# Environent variables
# ============================================================================

export DOTPATH=$HOME/git/dotfiles
export EDITOR="vim"
export FZFPATH=$HOME/.fzf
export PATH="/usr/local/Cellar/git/2.17.0/bin:${FZFPATH}/bin:${DOTPATH}/bin:$GOPATH/bin:/usr/local/go/bin:${PATH}"
export GOPATH=$HOME/dev
# dircolors
export LSCOLORS=exgxcxdxbxegedabagacad

export PKG_CONFIG_PATH=$HOME/.pkgconfig

PROMPT="[%n %~] \$vcs_info_msg_0_ %% "

export GIT_EDITOR=vim

export CONFIGCTL_TEST_PRIVATE_KEY=$HOME/sandbox/configctl/.vagrant/machines/default/virtualbox/private_key

# ============================================================================
# alias
# ============================================================================

alias ls='ls -G'
alias grep='grep -d skip'
alias t='vim ~/Text/inbox.md'
alias sed='gsed'
alias tmux="TERM=screen-256color-bce tmux"
alias vimf='vim $(fzf)'
#if [ -n $TMUX ]; then
#   alias vim="TERM=screen-256color vim"
#fi
#alias vim="nvim"
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
zstyle ':vcs_info:git:*' formats '(%b) '

precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
precmd_vcs_info() { 
	vcs_info 
	RPROMPT="%F{green}${vcs_info_msg_0_}%f"
}

PROMPT="%F{green}(%n)%f => %c %% "

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
# peco-configurations
# ============================================================================

function peco-multi-ssh () {
    local hosts="$(grep -iE '^host[[:space:]]+[^*]' ~/.ssh/config | awk '{print $2}' | peco)"
    #local hosts="$(cat ~/.ssh/known_hosts | awk -F ',' '{print $1}' | peco)"
    if [ -n "$hosts" ]; then
        tmux-multi-pane-ssh "${=hosts}"
    fi
    zle clear-screen
}

zle -N peco-multi-ssh
bindkey '^]' peco-multi-ssh

function peco-cdr-history () {
    local selected_dir="$(cdr -l | sed 's/^[0-9]\+ \+//' | peco --prompt="cdr >" --query "$LBUFFER")"
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
}
zle -N peco-cdr-history
bindkey '^H' peco-cdr-history

function peco-ghq-src() {
    local src=$(ghq list -full-path | peco --query "$LBUFFER")
    if [ -n "$src" ]; then
        BUFFER="cd $src"
        zle accept-line
    fi
    zle -R -c
}
zle -N peco-ghq-src
bindkey '^[' peco-ghq-src

function peco-chrome-bookmark(){
	vivaldi-bookmark.rb
}
zle -N peco-chrome-bookmark
bindkey '^K' peco-chrome-bookmark

peco-vivaldi-history() {
  local cols sep google_history open
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  if [ "$(uname)" = "Darwin" ]; then
    vivaldi_history="$HOME/Library/Application Support/Vivaldi/Default/History"
    open=open
  else
    #google_history="$HOME/.config/google-chrome/Default/History"
    open=xdg-open
  fi
  cp -f "$vivaldi_history" /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  %s\n", $1, $2}' | 
  peco  --prompt "[url]" | sed 's#.*\(https*://\)#\1#' | xargs $open > /dev/null 2> /dev/null

}
zle -N peco-vivaldi-history
bindkey '^U' peco-vivaldi-history

# ============================================================================
# Load func
# ============================================================================

if [ -e ~/company ];then
	for f (~/company/*.zsh) source "${f}"
fi

# fzf default keybindings and completion
for f (${FZFPATH}/**/*.zsh) source "${f}"

# git-extras completion
source ${DOTPATH}/git-extras-completion.zsh

eval "$(direnv hook zsh)"

# ============================================================================
# envrc
# ============================================================================
pyenv local 3.6.1


