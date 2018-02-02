# Setup fzf
# ---------
if [[ ! "$PATH" == *$HOME/.vim/bundles/repos/github.com/junegunn/fzf/bin* ]]; then
  export PATH="$PATH:$HOME/.vim/bundles/repos/github.com/junegunn/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/.vim/bundles/repos/github.com/junegunn/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$HOME/.vim/bundles/repos/github.com/junegunn/fzf/shell/key-bindings.zsh"

