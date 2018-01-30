#!/usr/bin/env bash
#
# Intended to be cloned and run, not sourced from github
#
# This assumes zsh is already installed.

DOTFILES=$HOME/.dotzsh
DOTFZF=$HOME/.fzf
DOTLOCAL=$HOME/.local/share/dotfiles

GITCLONE="git clone --depth=1"

# cd $HOME
# rm -rf $DOTFILES
# mkdir $DOTFILES
# cd $DOTFILES

# git init
# git remote add origin git@github.com:balhaut/dotzsh.git
# git pull origin master

# Start from scratch.
rm -rf \
  $DOTFZF \
  $DOTLOCAL \
  $HOME/.zshrc

ln -s $DOTFILES/zshrc $HOME/.zshrc

# Install FZF with key bindings and completion.
$GITCLONE https://github.com/junegunn/fzf.git $DOTFZF
$DOTFZF/install --key-bindings --completion --no-update-rc

# Clone any ZSH plugins.
mkdir -p $DOTLOCAL
$GITCLONE https://github.com/zsh-users/zsh-completions.git $DOTLOCAL/zsh-completions
$GITCLONE https://github.com/zsh-users/zsh-history-substring-search.git $DOTLOCAL/zsh-history-substring-search
$GITCLONE https://github.com/zsh-users/zsh-syntax-highlighting.git $DOTLOCAL/zsh-syntax-highlighting
$GITCLONE https://github.com/rupa/z.git $DOTLOCAL/z
if [ ! -f "$HOME/.z" ]; then
  touch $HOME/.z
fi

cd $HOME
rm -f $HOME/.zcompdump*

# Python virtualenvwrapper
pip install --upgrade --user virtualenvwrapper
