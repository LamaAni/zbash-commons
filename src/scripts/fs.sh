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

    echo "$rslt"

    # pattern="$(regexp_replace "/[X]+/g" "\$0"$'\n' "$pattern")"
    # IFS=$'\n' lines=($pattern)
    # local loc=0
    # local rslt=""
    # local part=""

    # # echo "${lines[@]}"
    # for ln in "${lines[@]}"; do
    #     if [ -z "$ln" ]; then
    #         continue
    #     fi
    #     local ptrn_part="$(regexp_replace "[^X]+" "" "$ln")"
    #     local ptrn_rand="$(create_random_string "${#ptrn_part}")"
    #     # echo "$ptrn_part $ptrn_rand"
    #     part="$(replace_value_in_text "$ptrn_part" "$ptrn_rand" "$ln")"
    #     rslt="$rslt$part"
    #     loc=$((loc + 1))
    #     # echo "--"
    # done
    # echo "$rslt"
}
