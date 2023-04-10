#!/bin/bash

# AWS_PROFILE="$AWS_PROFILE" _awsp_prompt
AWS_PROFILE="$AWS_PROFILE"

if [ $# -ge 1 ]
then
  export AWS_PROFILE="$1"
  export AWS_DEFAULT_PROFILE="$1"
  echo "set profile: $AWS_PROFILE"
else
  CURRENT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  "$CURRENT/index.js"

  selected_profile="$(cat ~/.awsp)"

  if [ -z "$selected_profile" ]
  then
    unset AWS_PROFILE
    unset AWS_DEFAULT_PROFILE
  else
    export AWS_PROFILE="$selected_profile"
    export AWS_DEFAULT_PROFILE="$selected_profile"
  fi
fi

update_ps1() {
  local old_ps1="$1"
  local aws_regex='aws:\(([^)]*)\)'
  local new_profile="${AWS_PROFILE:-}"
  local new_ps1="$(echo $old_ps1 | sed -E "s/$aws_regex/$(printf '\e[1;34maws:(\e[1;33m%s\e[1;34m)\e[0m' "$new_profile")/g")"
  PS1="$new_ps1 "
}

update_ps1 "$PS1"
