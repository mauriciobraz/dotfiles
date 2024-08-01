if [ -z "$XDG_DATA_HOME" ]; then
  export XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
fi

if [ -z "$XDG_CONFIG_HOME" ]; then
  export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
fi

if [ -z "$XDG_CACHE_HOME" ]; then
  export XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
fi

for file in ${HOME}/.zaliases/*; do
  if [ -r $file ]; then
    source $file
  fi
done
