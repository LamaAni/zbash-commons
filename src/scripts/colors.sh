#!/bin/bash
: "${NO_COLORS:="false"}"
if [ "$NO_COLORS" != "true" ]; then
  export red=$'\e[0;31m'
  export green=$'\e[0;32m'
  export yellow=$'\e[0;33m'
  export blue=$'\e[0;34m'
  export magenta=$'\e[0;35m'
  export cyan=$'\e[0;36m'
  export light_blue=$'\e[0;94m'
  export deep_green=$'\e[0;32m'
  export dark_magenta=$'\e[0;35m'
  export dark_gray=$'\e[0;90m'
  export light_=$'\e[1;31m'
  export end_color=$'\e[0m'
  export ec="$end_color"
fi

function paint() {
  : "
Paint input with color, and add color end.
USAGE: paint [color] [text]
"
  local color="$1"
  local text="$2"
  echo "${!color}${text}${ec}"
}

function colorize() {
  : "
Color a text using a regular expression
USAGE: colorize [text] [regex] [color] [default color=\e[0m]
"
  local value="$1"
  local re="$2"
  local color_val="$3"
  local color_regular="$4"
  : ${color_regular:="\e[0m"}

  local to_print=""
  to_print="$(regexp_replace "($re)" "$color_val\$1${color_regular}" "$value")"
  echo "$to_print"
}
