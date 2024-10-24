# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch

# key binding
# bindkey -v # this enables vi mode inside of terminal, however it does not seem to be doing anything so I've removed that for now
#
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/aaron/.zshrc'

# load nvm
source /usr/share/nvm/init-nvm.sh

# load autosuggestions
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

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

# Subtituting prompt with my own
setopt prompt_subst
PS1='%F{blue}[%n@%m]%f %F{yellow}%~%f$(git_branch) > '

autoload -Uz compinit
compinit
# End of lines added by compinstall

alias ll='ls -la --color'
alias reload="source ~/.zshrc"
alias vim="nvim"
alias updt="sudo pacman -Syu"

# dir locations
alias usys="cd ~/Documents/repos/work/USYS.FE"
alias paint="cd ~/Documents/repos/school/paintify"
alias personal="cd ~/Documents/repos/personal/"
alias vimconfig="cd ~/.config/kickstart/"
alias dotfiles="cd ~/dotfiles"
alias pallet="cd ~/Documents/repos/school/palletify"
alias swrb="cd ~/Documents/repos/work/RB.Frontend"
alias runner="cd ~/Documents/repos/work/Runner"
alias rustapps="cd ~/Documents/repos/personal/rust_things"
alias nekrachni="cd ~/Documents/repos/work/nekrachni/frontend"
alias csharp="cd ~/Documents/repos/personal/csharp_things/"
alias knosq="cd ~/Documents/school/knosq/db_stuff/"
alias dipl="cd ~/Documents/repos/school/tauri-nextjs-template"

# shortands for various CLI tools
alias exruna="npx expo run:android"
alias exstart="npx expo start --clear"
alias exclean="npx expo prebuild --clean"
alias formatcommit="git commit --amend --no-edit -a"
alias lemon="cd ~/Documents/repos/work/Lemondia.Frontend"
alias emacs="vim"
alias startdocker="systemctl start docker"

# yarn packages paths
export PATH="$(yarn global bin):$PATH"

# nvim mason paths
export PATH=~/bin:/home/koen/.local/bin:$PATH
export PATH=~/.local/bin/:$PATH
export PATH=~/.local/share/nvim/mason/bin:$PATH
export PATH=~/.local/share/kickstart/mason/bin:$PATH

# android dev
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$HOME/Android/Sdk/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# dotnet stuff
export PATH="$PATH:/home/aaron/.dotnet/tools"

# pyenv load
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# editor variable
export EDITOR=nvim
export NVIM_APPNAME=kickstart

# fzf config + ctrl-f hotkey
export FZF_DEFAULT_COMMAND="fd --hidden"
function vzf() {
    local selected_file=$(fd --hidden . | fzf)
    [[ -n $selected_file ]] && nvim "$selected_file"
}
zle -N vzf
bindkey '^f' vzf

# set default browser
export BROWSER=brave

# always open tmux or attach to last session on startup
if [[ -z "$TMUX" ]] && [[ -n "$(tmux ls)" ]]; then
    tmux attach-session -d
else
    [ -z "$TMUX" ] && exec tmux
fi

