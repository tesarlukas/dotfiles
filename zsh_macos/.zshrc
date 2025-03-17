
# NOTE: not sure what this does for now, but it had to do something with
# skipping prompt being fucked when pressing tab
## export LC_ALL=en_US.UTF-8

# v mode
bindkey -v

# Reduce delay when switching modes (from 0.4 seconds to 0.1)
export KEYTIMEOUT=1

# Allow backspace to delete in insert mode
bindkey "^?" backward-delete-char

# similar to what I have by default on Linux
# bindkey "^l" end-of-line  # Ctrl+l, through Alacritty config it is made so that cmd+l sends to the terminal this sequence
bindkey '^L' end-of-line    # Option + L for end of line
bindkey '^K' clear-screen    # Control + L for clear screen


# Ensure the terminal properly recognizes Option+L
bindkey -s '\el' '\033[F'    # This helps ensure compatibility across different terminal emulators


# git branch name
function git_branch {
  branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  if [ -n "$branch" ]; then
    if [ $(git status --porcelain | wc -l) -ne 0 ]; then
      echo " %F{magenta}{$branch}%f"
    else
      echo " %F{green}{$branch}%f"
    fi
  fi
}


reinstall-xcode() {
    sudo rm -rf /Library/Developer/CommandLineTools
    xcode-select --install;
}

# Subtituting prompt with my own
setopt prompt_subst
PS1='%F{blue}[%n@%m]%f %F{yellow}%~%f$(git_branch) > '

# autoload -U colors && colors
# End of lines added by compinstall
autoload -Uz compinit
compinit

alias ll='ls -la --color'
alias reload="source ~/.zshrc"
alias vim="nvim"
alias ..="cd .."
alias emacs="vim"

# editor variable
export EDITOR=nvim
export NVIM_APPNAME=kickstart

# cd shortcuts
alias nekrachni="cd ~/documents/work/frontend/"
alias vimconfig="cd ~/.config/kickstart"
alias dotfiles="cd ~/dotfiles"

# cli shortcuts
alias exruna="npx expo run:android"
alias exclean="npx expo prebuild --clean"

# python
export PATH=$HOME/.pyenv/bin:$PATH
eval "$(pyenv init --path)"

#package manager for ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# load binaries
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH

#android official
export ANDROID_HOME="/usr/local/share/android-commandlinetools"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"

#mason packages
export PATH=$PATH:~/.local/share/kickstart/mason/bin
export PATH=$PATH:~/.local/share/nvim/mason/bin

# load .profile
[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

# Loading NVM
export NVM_DIR="$HOME/.nvm"
# This line creates a dummy nvm function
function nvm() {
    unset -f nvm
    # Load nvm
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    # Call nvm with our arguments
    nvm "$@"
}

# always open tmux or attach to last session on startup
if [[ -z "$TMUX" ]] && [[ -n "$(tmux ls)" ]]; then
  tmux attach-session -d
else
  [ -z "$TMUX" ] && exec tmux
fi

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
