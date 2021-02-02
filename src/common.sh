#!/bin/bash
: "${ZBASH_COMMONS_SCRIPTS_PATH:="$(dirname "${BASH_SOURCE[0]}")"}"
source "$ZBASH_COMMONS_SCRIPTS_PATH/common/core.sh" || exit $?

ZBASH_COMMONS_SCRIPTS_PATH="$(realpath "$ZBASH_COMMONS_SCRIPTS_PATH")"
export ZBASH_COMMONS_SCRIPTS_PATH

# -----------------------
# Loading

for file in $ZBASH_COMMONS_SCRIPTS_PATH/common/*; do
  source "$file"
  assert $? "Error while loading lib file: $file" || exit $?
done

export ZBASH_COMMONS_SCRIPTS_PATH
