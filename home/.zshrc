_PATH=(
  $PATH
  $HOME/.fnm
  $HOME/.cargo/bin
  $HOME/.local/bin
  $HOME/.pyenv/bin
  $HOME/.zfunctions
  $XDG_DATA_HOME/pnpm
)

export PATH="$(IFS=:; echo "${_PATH[*]}")"

if [[ -r "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Styles
zstyle ':omz:plugins:eza' 'git-status' yes
zstyle ':omz:plugins:eza' 'dirs-first' yes

zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

command -v eza &>/dev/null \
  && zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath' \
  || zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls     --color=always $realpath' \

setopt EXTENDED_GLOB

# Zinit Setup
local ZINIT_HOME="${XDG_DATA_HOME}/zinit/zinit.git"
local ZINIT_REPO="https://github.com/zdharma-continuum/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  mkdir -p "$ZSH_CACHE_DIR/completions"

  git clone "$ZINIT_REPO" "$ZINIT_HOME"
fi

# Zinit Plugins
source "${HOME}/.p10k.zsh"
source "${ZINIT_HOME}/zinit.zsh"

zi ice wait lucid atinit'zpcompinit; zpcdreplay'
zi  light zdharma/fast-syntax-highlighting

zi  ice wait lucid atload'_zsh_autosuggest_start'
zi  light zsh-users/zsh-autosuggestions

zi  wait lucid light-mode for \
  OMZ::lib/key-bindings.zsh \
  OMZ::lib/directories.zsh \
  OMZ::lib/completion.zsh \
  OMZ::lib/compfix.zsh \
  OMZ::lib/history.zsh

zi  wait lucid light-mode for \
  OMZP::command-not-found \
  OMZP::common-aliases \
  OMZP::git-commit \
  OMZP::extract \
  OMZP::dotenv \
  OMZP::pyenv \
  OMZP::bun \
  OMZP::dnf \
  OMZP::eza \
  OMZP::fnm \
  OMZP::fzf \
  OMZP::git \
  OMZP::npm \
  OMZP::rust \
  OMZP::sudo \
  OMZP::yarn

zi light Aloxaf/fzf-tab
zi light romkatv/powerlevel10k

zi ice wait lucid blockf atpull'zinit creinstall -q .'
zi light zsh-users/zsh-completions

# Used on some of my personal scripts.
# You should run "eval $(which shflags)" to use it.
zi ice as"program" cp"shflags -> shflags" pick"shflags"
zi light kward/shflags

# Load my scripts using ZI.
# Use "zi update -a -p" to update them.
for file in ${HOME}/.zfunctions/*(N-.); do
  zi ice mv"${file##*/} -> ${file##*/}" \
    pick"${file##*/}" as"program"; zi snippet "$file"
done

fpath+=${ZSH_CACHE_DIR}/completions
autoload -Uz compinit && compinit

sync() {
  zi update --all --parallel

  if command -v git &> /dev/null; then
    SYNC_DEST="$XDG_CACHE_HOME/${USER}/dotfiles"
    SYNC_REPO="https://github.com/mauriciobraz/dotfiles.git"

    [ -d "$SYNC_DEST" ] && cd "$SYNC_DEST" && git pull && cd -
    [ -d "$SYNC_DEST" ] || git clone "$SYNC_REPO" "$SYNC_DEST" && cd "$SYNC_DEST"

    rsync -avrhP home/.??* $HOME
  fi

  printf "Done! Please restart your terminal using ${COLORS[GREEN]}exec zsh${COLORS[RESET]}\n"
}


# Other
eval "$(fnm env)"
eval "$(pyenv init --path)"
eval "$(register-python-argcomplete pipx)"
