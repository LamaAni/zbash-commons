#!/bin/bash

function get_cur_branch() {
    : "
Returns the current git branch head.
USAGE: get_cur_branch
"
    git rev-parse --abbrev-ref HEAD
}

function get_cur_repo_name() {
    : "
Returns the current git repo name.
USAGE: get_cur_repo_name [label=origin]
"
    local label="$1"
    : "${label:="origin"}"

    local name="$(git remote get-url $label)"
    name="$(basename "$name")"
    name="${name%.*}"
    echo "$name"
}
