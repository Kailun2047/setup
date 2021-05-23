#!/bin/bash

sed_input_flag=-i
# Mac version of sed requires a back up suffix.
if [[ $(uname) == Darwin ]]; then
  sed_input_flag=-i\'bak\'
fi

function install_if_not_exist() {
  if [[ -z $(which $1) || $(which $1) == *"not found"* ]]; then
    ${install_command} $1
  else
    echo "$1 is already installed"
  fi  
}

function change_theme() {
  if [[ $1 == "agnoster" ]]; then
    git clone https://github.com/powerline/fonts.git --depth=1
    ./fonts/install.sh
    sudo rm -r ./fonts
  fi  
  sed ${sed_input_flag} -E "s/ZSH_THEME=\"[a-z]+\"/ZSH_THEME=\"$1\"/" ~/.zshrc
}

# Install git if not already installed.
install_if_not_exist git 

# Arm zsh with plugins.
if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi
if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi
sed ${sed_input_flag} -e
"s/plugins=(git)/plugins=(\ngit\nzsh-syntax-highlighting\nzsh-autosuggestions\n)/"
~/.zshrc

# Change zsh theme.
change_theme $1

source ~/.zshrc
