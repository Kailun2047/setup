#!/bin/bash

function install_if_not_exist() {
  if [[ -z $(which $1) || $(which $1) == *"not found"* ]]; then
    ${install_command} $1
  else
    echo "$1 is already installed"
  fi  
}

# Determine installation command by OS version.
# TODO: make this adaptable to more OS versions.
install_command="sudo apt install -y"
if [[ $(uname) == Darwin ]]; then
  install_command="brew install"
fi

echo "Installation command: ${install_command}"

# Install zsh.
${install_command} zsh

# Install cURL if not already installed.
install_if_not_exist curl

# Install oh-my-zsh.
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"



