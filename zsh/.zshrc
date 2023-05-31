# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch

# key binding
bindkey -v
bindkey "^[[1;5C" forward-word  # Ctrl + right arrow
bindkey "^[[1;5D" backward-word # Ctrl + left arrow
# bindkey "^?" delete-char -n


# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/aaron/.zshrc'

# load nvm
source /usr/share/nvm/init-nvm.sh

# git branch name
function git_branch {
  branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  if [ -n "$branch" ]; then
    if [ $(git status --porcelain | wc -l) -ne 0 ]; then
      echo " %F{red}{$branch}%f"
    else
      echo " %F{green}{$branch}%f"
    fi
  fi
}

setopt prompt_subst
#PROMPT='%F{blue}[%n@%m]%f %F{yellow}%~%f $(git_branch) %# '
PS1='%F{blue}[%n@%m]%f %F{yellow}%~%f$(git_branch) > '

autoload -Uz compinit
compinit
# End of lines added by compinstall

alias ll='ls -la'
alias reload="source ~/.zshrc"
alias usys="cd ~/Documents/repos/work/USYS.FE"
alias paint="cd ~/Documents/repos/school/paintify"
alias personal="cd ~/Documents/repos/personal/"
alias vim="nvim"
alias vimconfig="cd ~/.config/nvim"
alias dotfiles="cd ~/dotfiles"


export PATH=~/bin:/home/koen/.local/bin:$PATH
export PATH=~/.local/bin/:$PATH
export PATH=~/.local/share/nvim/mason/bin:$PATH



# android dev
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$HOME/Android/Sdk/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# always open tmux or attach to last session on startup
if [[ -z "$TMUX" ]] && [[ -n "$(tmux ls)" ]]; then
    tmux attach-session -d
else
    [ -z "$TMUX" ] && exec tmux
fi

