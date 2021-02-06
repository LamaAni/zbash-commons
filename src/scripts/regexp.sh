#!/bin/bash

function parse_regex_from_pattern() {
  local regex="$1"
  local flags=""
  local end_marker="--a-custom-marker-for-end-@%^^%^%"

  if [[ "$regex" != "/"* ]]; then
    printf "%s" "$regex"
    return 0
  fi

  flags="/$(parse_regex_flags_from_pattern "$regex")"

  # extract header
  regex="${regex#*"/"}"

  # remove flags
  regex="${regex}${end_marker}"
  regex="${regex//$flags$end_marker/}"
  echo "$regex"
}

function parse_regex_flags_from_pattern() {
  local regex="$1"
  local flags=""
  if [[ "$regex" != "/"* ]]; then
    printf "%s" ""
    printf "%s" "$regex"
  fi
  # extract header
  regex="${regex#*"/"}"

  # extract flags
  [[ "$regex" =~ \/[a-z]+$ ]]
  flags="${BASH_REMATCH[0]}"
  flags="${flags/[^a-z]/}"
  printf "%s" "$flags"
}

function replace_value_in_text() {
  : "
Does a simple text replace (all values).
USAGE: regexp_replace [value] [replace_with] [texts..]
"
  local value="$1"
  shift
  local replace_with="$1"
  shift
  local rslt=""
  local printed=""
  local before=""
  local after=""

  [ -n "$value" ]
  assert $? "Value must be defined" || return $?

  for text in "$@"; do
    rslt=()
    while [ -n "$text" ]; do
      if [[ "$text" != *"$value"* ]]; then
        rslt+=("$text")
        break
      fi
      before="${text%%"$value"*}"
      after="${text#*"$value"}"
      if [ -n "$before" ]; then
        rslt+=("$before")
      fi
      rslt+=("$replace_with")
      text="$after"
    done
    printed=""
    for r in "${rslt[@]}"; do
      printed="$printed$r"
    done
    echo "$printed"
  done
}

function regexp_replace() {
  : "
Does a regex replace. If a group is defined, will replace only the groups.
USAGE: regexp_replace /[regex]/[flags] [replace_with] [texts..]
"

  local regex="$1"
  local regex_flags="$(parse_regex_flags_from_pattern $regex)"
  local regex="$(parse_regex_from_pattern $regex)"

  local is_global=0
  local is_multiline=1

  if [[ "$regex_flags" == *"m"* ]]; then is_multiline=1; fi
  if [[ "$regex_flags" == *"g"* ]]; then is_global=1; fi
  if [[ "$regex_flags" == *"i"* ]]; then is_multiline=0; fi

  shift
  local replace_with="$1"
  shift

  [ -n "$regex" ]
  assert "$?" "You must provide a regular expression"

  function __regexp_replace__internal_replace_in_text() {
    local text="$1"
    local rslt=()
    local groups_count=""
    local match=""
    local match_groups=""
    local before=""
    local after=""
    local replace_groups=()

    while true; do
      if [[ "$text" =~ $regex ]]; then
        match_groups=("${BASH_REMATCH[@]}")
        match="${match_groups[0]}"
      else
        rslt+=("$text")
        break
      fi

      groups_count="${#match_groups[@]}"
      groups_count=$((groups_count - 1))

      replaces_match="$replace_with"
      replace_groups=($(seq 0 $groups_count))
      for i in "${replace_groups[@]}"; do
        replaces_match="$(replace_value_in_text "\$$i" "${match_groups[i]}" "$replaces_match")"
      done

      before="${text%%"$match"*}"
      after="${text#*"$match"}"
      if [ -n "$before" ]; then
        rslt+=("$before")
      fi
      rslt+=("$replaces_match")
      text="$after"
    done

    for r in "${rslt[@]}"; do
      printf "%s" "$r"
    done
  }

  local text=""
  local current=()
  while [ "$#" -gt 0 ]; do
    current=("$1")
    if [ $is_multiline -eq 0 ]; then
      IFS=$'\n' current=($(split $'\n' "$1"))
    fi
    for text in "${current[@]}"; do
      text="$(__regexp_replace__internal_replace_in_text "$text")"
      echo "$text"
    done
    shift
  done
}

function regexp_match() {
  : "
Does a regex match using grep
USAGE: regexp_match /[regex]/[flags] [vals ...]
"
  local regex="$1"
  local sep=""
  local before=""
  local after=""
  local current=""

  local regex_flags="$(parse_regex_flags_from_pattern $regex)"
  local regex="$(parse_regex_from_pattern $regex)"

  local is_global=0
  local is_multiline=1

  if [[ "$regex_flags" == *"m"* ]]; then is_multiline=1; fi
  if [[ "$regex_flags" == *"g"* ]]; then is_global=1; fi
  if [[ "$regex_flags" == *"i"* ]]; then is_multiline=0; fi
  [ -n "$regex" ]
  assert "$?" "You must provide a regular expression"

  shift
  while [ "$#" -gt 0 ]; do
    current=("$1")
    if [ $is_multiline -eq 0 ]; then
      IFS=$'\n' current=($(split $'\n' "$current"))
    fi
    for text in "${current[@]}"; do
      while [ -n "$text" ] && [[ "${text}" =~ ${regex} ]]; do
        # trim off the portion already matched
        sep="${BASH_REMATCH[0]}"
        before="${text%%"$sep"*}"
        after="${text#*"$sep"}"
        text="$after"

        echo "${BASH_REMATCH[@]}"
        if [ $is_global -ne 1 ]; then
          break
        fi
      done
    done
    shift
  done
}
