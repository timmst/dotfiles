# Set up the prompt

autoload -Uz promptinit
promptinit

# Git autoload
autoload -Uz compinit && compinit

# vcs_info framework to get git branch info
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
PROMPT='%F{208}%n%f %F{083}%~%f %F{033}${vcs_info_msg_0_} -> '
zstyle ':vcs_info:git:*' formats '%b'

setopt histignorealldups sharehistory

# start postgres service
# wsl.exe -u root service postgresql status > /dev/null || wsl.exe -u root service postgresql start > /dev/null

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# https://github.com/zsh-users/zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# nvm
export NVM_DIR=~/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Append custom scripts directory to $PATH (using special ZSH mapping of environment variables)
path+=(~/bin)
export PATH

# Go
# export GOPATH=$HOME/go
# export GOROOT=/usr/local/opt/go/libexec
# export GOBIN=$GOPATH/bin
# export PATH=$PATH:$GOPATH
# export PATH=$PATH:$GOROOT/bin[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
