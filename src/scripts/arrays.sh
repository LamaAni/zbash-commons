#!/bin/bash
function join_by() {
  : "
Join array arguments
USAGE: join_by [sep] [values..]
  "
  local sep="$1"
  shift
  local joined=""
  while [ $# -gt 1 ]; do
    joined="$joined$1$sep"
    shift
  done
  joined="$joined$1$sep"
  printf "%s" "$joined"
}

function unique_array_values() {
  : "
Return the unique array values
USAGE: unique_array_values [values...]
"
  sorted=($(sort_array_values "$@"))
  local unique=($(join_by $'\n' "${sorted[@]}" | uniq))
  echo "${unique[@]}"
}

function sort_array_values() {
  : "
Sort array values
USAGE: sort_array_values [values...]
"
  local sorted=($(join_by $'\n' "$@" | sort))
  echo "${sorted[@]}"
}
