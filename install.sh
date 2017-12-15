#!/bin/sh

# zsh
if [ ! -h $HOME/.zshrc ]; then
    ln -sn $HOME/git/dotfiles/.zshrc $HOME/.zshrc
fi

# vim
if [ ! -d $HOME/.vim ]; then
    mkdir -p $HOME/.vim
fi

if [ ! -h $HOME/.vim/config ]; then
    ln -sn $HOME/git/dotfiles/vim/config $HOME/.vim/config
fi

if [ ! -h $HOME/.vim/ftplugin ]; then
    ln -sn $HOME/git/dotfiles/vim/ftplugin $HOME/.vim/ftplugin
fi

if [ ! -h $HOME/.vim/pluginconfig ]; then
    ln -sn $HOME/git/dotfiles/vim/pluginconfig $HOME/.vim/pluginconfig
fi

if [ ! -h $HOME/.vim/dein.toml ]; then
    ln -sn $HOME/git/dotfiles/vim/dein.toml $HOME/.vim/dein.toml
fi

if [ ! -h $HOME/.vim/dein_lazy.toml ]; then
    ln -sn $HOME/git/dotfiles/vim/dein_lazy.toml $HOME/.vim/dein_lazy.toml
fi

if [ ! -h $HOME/.vimrc ]; then
    ln -sn $HOME/git/dotfiles/.vimrc $HOME/.vimrc
fi

# tig
if [ ! -h $HOME/.tigrc ]; then
    ln -sn $HOME/git/dotfiles/.tigrc $HOME/.tigrc
fi

