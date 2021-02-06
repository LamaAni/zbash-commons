# zbash-commons

A common bash library that adds loging, regex and other usefull commands to bash

## BETA

# To install

```shell
curl -Ls "https://raw.githubusercontent.com/LamaAni/zbash-commons/master/install?ts_$(date +%s)=$RANDOM" | sudo bash
```

# To use in a script

At the head of your script add,

```shell
source zbash_commons
if [ $? -ne 0 ]; then
  echo "zbash_commons not found. Please see: https://github.com/LamaAni/zbash-commons"
fi

```

# To use in a temp script, or install script

### NOTE: requires internet connection

At the head of your script

```shell
type zbash_commons &>/dev/null
if [ $? -ne 0 ]; then
  echo "[DOWNLOAD] Downloading zbash_commons from latest release.."
  ZBASH_COMMONS_GET_SCRIPT="$(curl -Ls "https://raw.githubusercontent.com/LamaAni/zbash-commons/master/get?ts_$(date +%s)=$RANDOM")"
  ZBASH_COMMONS="$(bash -c "$ZBASH_COMMONS_GET_SCRIPT")"
  eval "$ZBASH_COMMONS"
else
  source zbash_commons
fi
```
# envs

name | Description | Default value
---|---|---
LOG_LEVEL | The log level (TRACE, DEBUG, INFO, WARN, ERROR, CRITICAL) | INFO
LOG_DISPLAY_DATE_TIME | the date time format to display | %Y-%m-%dT%H:%M:%S%z
NO_COLORS | Do not display colors | false

# methods
Name | Description | Usage
--- | --- | ---
join_by | Join array arguments | join_by [sep] [values..]
unique_array_values | Return the unique array values | unique_array_values [values...]
sort_array_values | Sort array values | sort_array_values [values...]
paint | Paint input with color, and add color end. | paint [color] [text]
colorize | Color a text using a regular expression | colorize [text] [regex] [color] [default color=\e[0m]
assert | Assert an code, if > 0, then log:error, returns the code. | assert [code|\$?] [message...] -> code
warn | Assert an code, if > 0, then log:warn the message, returns the code. | assert [code|\$?] [message...] -> code
log:debug | Log a message to level: DEBUG | log:debug [message...]
log:trace | Log a message to level: TRACE | log:trace [message...]
log:info | Log a message to level: INFO | log:info [message...]
log:warn | Log a message to level: WARN | log:warn [message...]
log:error | Log a message to level: ERROR | log:error [message...]
log:critical | Log a message to level: ERROR | log:critical [message...]
log | Log a message to level: INFO | log:info [message...]
log:sep | Output a seperator for nicer logging. (Dose not have) | log:sep [message...]
is_interactive_shell | Returns 1 if its an interactive shell | is_interactive_shell
is_command | Echo true if a command is defined. To be used in if | is_command command
check_access | Checks access to a file or folder. | check_access [file or folder]
get_cur_branch | Returns the current git branch head. | get_cur_branch
get_cur_repo_name | Returns the current git repo name. | get_cur_repo_name [label=origin]
get_github_latest_release | Returns the github latest release url. | get_github_latest_release [repo]
get_github_latest_release_downloads_url | Returns the github latest release downloads url. | get_github_latest_release_downloads_url [repo]
get_github_latest_release_version | Returns the github latest release version | get_github_latest_release_version [repo]
log:help | Create colorized help | log:help [help text ...]
read_from_pipe | Read from pipe if exists. | read_from_pipe
get_input | Gets input from the user | get_input [question] [default]
get_menu_value | Return a menu value from a list of options. | get_input [question] [values...]
get_yes_no | Asks a yes no question. Returns 1 if yes. | get_yes_no [question]
validate_arg | Validates a value is not empty (with trim) | validate_arg [value]
is_chromeos | True if chromeos | is_chromeos
is_wsl | True if wsl | is_wsl
get_os_release | Exports the os release into envs: OS_NAME, OS_VERSION, OS_VERSION_CODENAME. Returns the os_name | get_os_release
replace_value_in_text | Does a simple text replace (all values i.e. /g). | regexp_replace [value] [replace_with] [texts..]
regexp_replace | Does a regex replacve using bash native commands. flags can be [g,m,i] | regexp_replace /[regex]/[flags] [replace_with] [texts..]
regexp_match | Does a regex match using bash native commands. flags can be [g,m,i] | regexp_match /[regex]/[flags] [vals ...]
replace_with_env | Replaces values inside a text with matching env valus (similar to python format), e.g. '{{ENV}}' -> 'Env_val' | replace_with_env [text]
to_lowercase | Makes a text lowercase | to_lowercase [text]
trim | Trim a text | trim [text]
trim_empty_lines | Trim only the empty lines of a text. | trim_empty_lines [text]
create_random_string | Create a random string value. (ubuntu) | create_random_string [count]
multi_print | Duplicate a text n times. | multi_print [text] [count]
indent | Indent a multiline text by n chars forward. | indent [text] [count] [symbol=' ']
split | Split a string by an seperator (multuichar) | split [sep] [text...]
# Licence

Copyright ©
`Zav Shotan` and other [contributors](../../graphs/contributors).
It is free software, released under the MIT licence, and may be redistributed under the terms specified in [LICENSE](LICENSE).
