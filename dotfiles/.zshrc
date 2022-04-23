# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Install Oh My Zsh if it isn't already present
if [ ! -d $ZSH ]; then
  echo "Cloning Oh My Zsh..."
  git clone https://github.com/ohmyzsh/ohmyzsh.git $ZSH

  echo "Oh My Zsh cloned, now reopen your terminal to finish the installation."
  exit
fi

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  dotenv
  git
  vscode
  yarn
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Aliases
#
# It requires to install the commitizen-cli (npm i -g commitizen)
alias gcz="git cz"

# Load all the aliases inside .zsh folder.
# The file name must follow the format "*.alias.zsh"
source $HOME/.zsh/*.alias.zsh

# Optional tools, you don't need to install them, if you don't want to.
#
# To install Cargo/Rust, follow the instructions at the official website.
# https://www.rust-lang.org/tools/install
[ -s $HOME/.cargo/env ] && source $HOME/.cargo/env &>/dev/null

# The following commands will install and load some important tools.
# You can add more tools to this list as you wish.

# Install and/or load Node Version Manager (NVM)
# https://github.com/nvm-sh/nvm
export NVM_DIR="$HOME/.nvm"

source $NVM_DIR/nvm.sh &>/dev/null || {
  git clone https://github.com/nvm-sh/nvm.git $NVM_DIR
  source $NVM_DIR/nvm.sh
}

source $NVM_DIR/bash_completion

# Plugin manager for ZSH
# https://github.com/z-shell/zi
export ZI_DIR="$HOME/.zi"

source "$ZI_DIR/bin/zi.zsh" &>/dev/null || {
  git clone https://github.com/z-shell/zi $ZI_DIR/bin
  source "$ZI_DIR/bin/zi.zsh"
}

autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi
zicompinit

zi light-mode for \
  zsh-users/zsh-autosuggestions \
  zsh-users/zsh-completions \
  zsh-users/zsh-syntax-highlighting
