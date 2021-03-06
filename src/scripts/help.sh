#!/bin/bash
function log:help() {
  : "
Create colorized help
USAGE: log:help [help text ...]
"
  echo
  local help_text=""
  help_text="$@"

  # set tab length
  if [[ ! "$OSTYPE" == "darwin"* ]]; then tabs 2; fi

  help_text=$(trim "$help_text")
  help_text=$(colorize "$help_text" "/[^a-zA-Z0-9_]-[a-zA-Z0-9_-]+/i" "${yellow}")
  help_text=$(colorize "$help_text" "/^[a-zA-Z0-9_-]+:/i" "${green}")
  help_text=$(colorize "$help_text" '\[[a-zA-Z0-0_-]+\]' "${cyan}")

  echo -e "$help_text"
  if [[ ! "$OSTYPE" == "darwin"* ]]; then tabs -8; fi
  echo
}
