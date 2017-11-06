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
