#!/bin/bash
function make_temp_path() {
    local pattern="$1"
    : "${pattern:="/tmp/templfile.XXXXXX.XXX"}"

    local rstr=""
    local x_ph=""
    local x_placeholders
    x_placeholders=($(regexp_match "/[X]+/g" /tmp/templfile.XXXXXX.XXX))

    rslt="$pattern"
    for x_ph in "${x_placeholders[@]}"; do
        rstr="$(create_random_string "${#x_ph}")"
        rslt="$(regexp_replace "/$x_ph/" "$rstr" "$rslt")"
    done

    printf "%s" "$rslt"
}
