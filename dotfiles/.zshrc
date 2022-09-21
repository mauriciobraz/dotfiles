export ZSH="$HOME/.oh-my-zsh"

if [ ! -d $ZSH ]; then
  git clone https://github.com/ohmyzsh/ohmyzsh.git $ZSH
  echo "Oh My Zsh was successfully installed, restart the terminal to continue."
fi

ZSH_THEME="robbyrussell"

plugins=(
  dotenv
  git
  vscode
  yarn
)

source $ZSH/oh-my-zsh.sh

# User configuration
# User configuration
# User configuration

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

# Install and/or load Node Version Manager (NVM)
# https://github.com/nvm-sh/nvm
export NVM_DIR="$HOME/.nvm"

source $NVM_DIR/nvm.sh &>/dev/null || {
  git clone https://github.com/nvm-sh/nvm.git $NVM_DIR
  source $NVM_DIR/nvm.sh
}

source $NVM_DIR/bash_completion

# To install Cargo/Rust, follow the instructions at the official website.
# https://www.rust-lang.org/tools/install
[ -s $HOME/.cargo/env ] && source $HOME/.cargo/env &>/dev/null

# It requires to install the commitizen-cli (pnpm add --global commitizen)
alias gcz="git cz"

# Aliases for pnpm
# Aliases for pnpm
# Aliases for pnpm

alias p="pnpm"
alias px="pnpm dlx"
alias pi="pnpm init"

# Packages
alias pa="pnpm add"
alias pad="pnpm add --save-dev"
alias prm="pnpm remove"
alias pin="pnpm install"
alias pun="pnpm uninstall"
alias pls="pnpm list"
alias pout="pnpm outdated"
alias pau="pnpm audit"
alias pup="pnpm update"

# Packages (Global)
alias pga="pnpm add --global"
alias pgls="pnpm list --global"
alias pgrm="pnpm remove --global"
alias pgu="pnpm update --global"

# Scripts
alias pd="pnpm run dev"
alias pb="pnpm run build"
alias pst="pnpm run start"
alias psd="pnpm run start:dev"

# Remove all node_modules folders recursively from a folder.
# Defaults to the current directory.
function purge-node-modules {
  if [ ! -d $1 ]; then
    echo "Error: The specified directory does not exist."
  else
    command find $1 -name "node_modules" -type d -prune -print | xargs du -chs
  fi
}
