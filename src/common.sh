#!/bin/bash
: "${ZBASH_COMMONS_SCRIPTS_PATH:="$(dirname "${BASH_SOURCE[0]}")"}"

function load_core_scripts() {
  source "$ZBASH_COMMONS_SCRIPTS_PATH/common/core.sh"
  if [ $code -ne 0 ]; then
    echo "zbash-commons: Error loading core script."
    return $?
  fi
}

function load_scripts() {
  for file in $ZBASH_COMMONS_SCRIPTS_PATH/common/*; do
    source "$file"
    assert $? "Error while loading lib file: $file" || exit $?
  done
}

ZBASH_COMMONS_SCRIPTS_PATH="$(realpath "$ZBASH_COMMONS_SCRIPTS_PATH")"
export ZBASH_COMMONS_SCRIPTS_PATH

# -----------------------
# Loading

load_core_scripts && load_scripts
