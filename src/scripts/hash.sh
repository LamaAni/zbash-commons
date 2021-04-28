#!/bin/bash
function get_folder_md5() {
    : "
Calculates the md5 hash of fild/folder contents. (Dose not include file changed times)
USAGE: get_folder_md5 [src]
"
    local src="$1"
    local file_hashes=""

    file_hashes="$(find "$src" -type f 2>&1 | sort -s -b | xargs md5sum | grep --color=never -Eo '^[a-zA-Z0-9]+')"
    assert $? "Failed to calculate file hashes @ $src"$'\n'"${file_hashes}" 1>&2 || return $?

    echo "$file_hashes" | md5sum | grep --color=never -Eo '^[a-zA-Z0-9]+'
    assert $? "Failed to calculate md5" 1>&2 || return $?
}
