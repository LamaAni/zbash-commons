#!/bin/bash
function replace_with_env() {
  : "
Replaces values inside a text with matching env valus (similar to python format), e.g. \"{{ENV}}\" -> \"Env_val\"
USAGE: replace_with_env [text]
"
  # replace any {{ENV_NAME}} with its respective env value.
  value="$1"

  # the regular expression matches {{ [SOME NAME] }}
  re='(.*)\{\{[   ]*([a-zA-Z0-9_-]+)[   ]*\}\}(.*)'

  # search for all replacements.
  while [[ "$value" =~ $re ]]; do
    env_name=${BASH_REMATCH[2]}
    env_value=${!env_name}
    value="${BASH_REMATCH[1]}${env_value}${BASH_REMATCH[3]}"
  done

  echo "$value"
}

function to_lowercase() {
  : "
Makes a text lowercase
USAGE: to_lowercase [text]
"
  local text="$1"
  echo "${text,,}"
}

function trim() {
  : "
Trim a text
USAGE: trim [text]
"
  local var="$*"
  # remove leading whitespace characters
  var="${var#"${var%%[![:space:]]*}"}"
  # remove trailing whitespace characters
  var="${var%"${var##*[![:space:]]}"}"
  echo -n "$var"
}

function trim_empty_lines() {
  : "
Trim only the empty lines of a text.
USAGE: trim_empty_lines [text]
"
  local value="$1"
  if [[ "$OSTYPE" == "darwin"* ]]; then
    printf "%s" "$1"
  else
    printf "%s" "$1" | sed -r '/^\s*$/d'
  fi
}

function create_random_string() {
  : "
Create a random string value. (ubuntu)
USAGE: create_random_string [count]
"
  local count="$1"
  : ${count:=5}
  cat /dev/urandom | env LC_CTYPE=C tr -dc a-z0-9 | head -c $count
}

function multi_print() {
  : "
Duplicate a text n times.
USAGE: multi_print [text] [count]
"
  local text="$1"
  local count="$2"

  [ -n "$text" ]
  assert $? "You must send the text" || return $?
  [ -n "$count" ]
  assert $? "You must send the indent count" || return $?

  for i in $(seq 1 $count); do
    printf "%s" "$text"
  done
}

function indent() {
  : "
Indent a multiline text by n chars forward.
USAGE: indent [text] [count] [symbol=\" \"]
"
  local text="$1"
  local count="$2"
  local symbol="$3"

  [ -n "$text" ]
  assert $? "You must send the text" || return $?
  [ -n "$count" ]
  assert $? "You must send the indent count" || return $?

  : ${symbol:=" "}
  local replace_with=$(multi_print "$symbol" $count)

  regexp_replace "^" "$replace_with" "$text"
}

function split() {
  local by="$1"
  for text in "$@"; do
    while [ -n "$text" ]; do
      if [[ "$text" != *"$by"* ]]; then
        echo "$text"
        break
      fi
      before="${text%%"$by"*}"
      after="${text#*"$by"}"
      if [ -n "$before" ]; then
        echo "$before"
      fi
      text="$after"
    done
  done
}
