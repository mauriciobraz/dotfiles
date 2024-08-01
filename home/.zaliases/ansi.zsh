typeset -A COLORS=(
  [BOLD]="\033[1m"
  [RESET]="\033[0m"
  [FAINT]="\033[2m"
  [STRIKE]="\033[9m"
  [INVERSE]="\033[7m"
  [UNDERLINE]="\033[4m"

  # Text
  [RED]="\033[31;31m"
  [BLUE]="\033[34;34m"
  [CYAN]="\033[36;36m"
  [BLACK]="\033[30;30m"
  [GREEN]="\033[32;32m"
  [WHITE]="\033[37;37m"
  [YELLOW]="\033[33;33m"
  [MAGENTA]="\033[35;35m"
  [DEFAULT]="\033[39;39m"

  # Background
  [BG_RED]="\033[41;41m"
  [BG_BLUE]="\033[44;44m"
  [BG_CYAN]="\033[46;46m"
  [BG_BLACK]="\033[40;40m"
  [BG_GREEN]="\033[42;42m"
  [BG_WHITE]="\033[47;47m"
  [BG_YELLOW]="\033[43;43m"
  [BG_MAGENTA]="\033[45;45m"
  [BG_DEFAULT]="\033[49;49m"
)

for COLOR in ${(k)COLORS}; do
  COLORS[${(L)COLOR}]="${COLORS[${COLOR}]}"
done

# Presets
ansi::reset() { printf "${COLORS[RESET]}" }
ansi::bold() { printf "${COLORS[BOLD]}%s${COLORS[RESET]}" "$@" }
ansi::info() { printf "${COLORS[BLUE]}${COLORS[BOLD]}%s${COLORS[RESET]}\n" "$@" }
ansi::error() { printf "${COLORS[RED]}${COLORS[BOLD]}%s${COLORS[RESET]}\n" "$@" }
ansi::debug() { printf "${COLORS[BLACK]}${COLORS[BOLD]}%s${COLORS[RESET]}\n" "$@" }
ansi::success() { printf "${COLORS[GREEN]}${COLORS[BOLD]}%s${COLORS[RESET]}\n" "$@" }
ansi::warning() { printf "${COLORS[YELLOW]}${COLORS[BOLD]}%s${COLORS[RESET]}\n" "$@" }
ansi::underlined_uri() { printf "${COLORS[BLUE]}${COLORS[UNDERLINE]}%s${COLORS[RESET]}" "$@" }
