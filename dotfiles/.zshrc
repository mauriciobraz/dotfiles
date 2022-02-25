# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

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
  dotenv git vscode yarn zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

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

# Install ZShell Package Manager (ZPM)
# https://github.com/zpm-zsh/zpm
export ZPM_DIR="$HOME/.zpm"

source $ZPM_DIR/zpm.zsh &>/dev/null || {
  git clone https://github.com/zpm-zsh/zpm.git $ZPM_DIR
  source $ZPM_DIR/zpm.zsh
}

zpm load \
  zsh-users/zsh-autosuggestions,zsh-completions
