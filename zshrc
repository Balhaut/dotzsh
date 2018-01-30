#!/usr/bin/env zsh

export DOTFILES=$HOME/.dotzsh
export INCLUDES=$HOME/.local/share/dotfiles

source $DOTFILES/aliases_functions
# source $DOTFILES/theme

source $INCLUDES/zsh-completions/zsh-completions.plugin.zsh
source $INCLUDES/zsh-history-substring-search/zsh-history-substring-search.zsh
source $INCLUDES/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $INCLUDES/z/z.sh


HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

autoload -U compinit && compinit
zmodload -i zsh/complist

# http://zsh.sourceforge.net/Doc/Release/Options.html
unsetopt menu_complete
unsetopt flowcontrol

setopt prompt_subst
setopt always_to_end
setopt append_history
setopt auto_menu
setopt complete_in_word
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt interactivecomments
setopt share_history

bindkey -v

bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^f' forward-word
bindkey '^b' backward-word

# History-by-command (default in oh-my-zsh)
bindkey '^[[A' up-line-or-search                                                
bindkey '^[[B' down-line-or-search

export EDITOR='vim'
export CLICOLOR=1
export LSCOLORS=Gxfxcxdxbxegedabagacad

# Prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

function git_prompt() {
    BRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/*\(.*\)/\1/')
    if [ ! -z $BRANCH ]; then
        echo -n "%F{yellow}${BRANCH}%F{reset}"
        if [ ! -z "$(git status --short)" ]; then
            echo " %F{red}✗"
        fi
    fi
}
function virtualenv_info() {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

PS1='%F{green}$(virtualenv_info)%F{reset}$(git_prompt)%F{red}[%2~]%F{reset}%F{yellow}%(?..[%?] )%F{reset}> '

# Ensure /usr/local/bin is on the path (PyCharm bug)
if [[ ! $PATH =~ ".*/usr/local/bin.*" ]]; then
    export PATH="$PATH:/usr/local/bin"
fi

# Pip's user install path
export PATH="$HOME/Library/Python/2.7/bin:$PATH"

# ITerm2 v3 Beta shell integration
if [ -f "$HOME/.iterm2_shell_integration.zsh" ]; then
    source $HOME/.iterm2_shell_integration.zsh
fi

source $HOME/.fzf.zsh
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

# Disable creating the '._blah' metadata files when calling tar.
export COPYFILE_DISABLE=true

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Python (homebrew) PATH
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# Ruby local gem installs PATH
LOCALGEMS="$HOME/.gem/ruby/2.4.0/bin"
if [ -d "$LOCALGEMS" ]; then
    export PATH="${LOCALGEMS}:${PATH}"
else
    echo "Warning: expected local gem install folder not present: ${LOCALGEMS}."
fi

# Python virtualenvwrapper
export WORKON_HOME=$HOME/.venvs
export PROJECT_HOME=$HOME/Projects
export VIRTUALENVWRAPPER_SCRIPT=$HOME/Library/Python/2.7/bin/virtualenvwrapper.sh
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2
source $HOME/Library/Python/2.7/bin/virtualenvwrapper_lazy.sh

# Perl
PATH="/Users/carnold/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/carnold/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/carnold/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/carnold/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/carnold/perl5"; export PERL_MM_OPT;

# Nginx/Openresty
export TEST_NGINX_BINARY=openresty

# Rust
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH:$HOME/fly"
