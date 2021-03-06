#!/bin/bash
function is_chromeos() {
  : "
True if chromeos
USAGE: is_chromeos
"
  if [ -d '/mnt/chromeos' ]; then
    echo "true"
    return 0
  fi
  echo "false"
}

function is_wsl() {
  : "
True if wsl
USAGE: is_wsl
"
  if [ -n "$(cat cat /proc/version | grep 'Microsoft')" ]; then
    echo "true"
    return 1
  else
    echo "false"
    return 0
  fi
}

function get_os_release() {
  : "
Exports the os release into envs: OS_NAME, OS_VERSION, OS_VERSION_CODENAME. Returns the os_name
USAGE: get_os_release
"
  source /etc/os-release
  export OS_NAME="$ID"
  export OS_VERSION="$VERSION_ID"
  export OS_VERSION_CODENAME="$VERSION_CODENAME"
  echo "$OS_NAME"
}
