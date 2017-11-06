function peco-command-history() {
    BUFFER="$(history -nr 1 | awk '!a[$0]++' | peco --query "$LBUFFER" | sed 's/\\n/\n/')"
    CURSOR=$#BUFFER
    zle -R -c 
}
zle -N peco-command-history
bindkey '^R' peco-select-history

