export ZSH="$(which zsh)"

# Loads Zinit or installs it if it's not installed.
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
zicompinit

## Load Pure Prompt theme for ZSH.
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure

## This is a workaround for the empty line this theme prints before the prompt.
## https://github.com/sindresorhus/pure/issues/509#issuecomment-641001784
print() {
  [ 0 -eq $# -a "prompt_pure_precmd" = "${funcstack[-1]}" ] || builtin print "$@";
}

## Load plugins and snippets.
zinit for \
  light-mode \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-completions \
    zsh-users/zsh-syntax-highlighting

zinit snippet OMZP::git
zinit snippet OMZP::yarn
zinit snippet OMZP::dotenv
zinit snippet OMZP::vscode

zinit wait lucid as"completion" for \
    OMZP::docker/_docker \
    OMZP::docker-compose/_docker-compose

zinit light ntnyq/omz-plugin-pnpm

# User Configuration
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

## Load or install NVM.
export NVM_HOME="$HOME/.nvm"

source $NVM_HOME/nvm.sh || {
  git clone https://github.com/nvm-sh/nvm.git $NVM_HOME &>/dev/null
  source $NVM_HOME/nvm.sh
}
