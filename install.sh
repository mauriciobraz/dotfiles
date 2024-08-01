if [ "$(id -u)" -ne 0 ]; then
  sudo sh "$0" "$@"
  exit $?
fi

function bak() {
  if [ -n $(find "${@}" -prune -empty 2>/dev/null) ]; then
    echo "There are no files to backup inside '${@}'." && exit 1
  fi

  for PATH in "${@}"; do
    if [ -f "$PATH" ] || [ -d "$PATH" ]; then
      mv "$PATH" "$PATH.$(date +%Y_%m_%d_%H_%M_%S).bak"
      echo "Moved '$PATH' to '$PATH.$(date +%Y_%m_%d_%H_%M_%S).bak'"
    fi
  done
}


USER=$(logname)
HOME=$(eval echo ~$USER)

DISTRO_ID=$(cat /etc/os-release | grep -w ID | cut -d= -f2)
BACKUP_FILES=$(find home -maxdepth 1 -type f -name '.*' -printf "%f ")

bak $BACKUP_FILES

rsync -avrhP etc/.??* /etc
rsync -avrhP home/.??* $HOME
