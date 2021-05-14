#!/bin/sh

AWS_PROFILE="$AWS_PROFILE" _awsp_prompt

if [ $# -ge 1 ]
then
  export AWS_PROFILE="$1"
  export AWS_DEFAULT_PROFILE="$1"
  echo "set profile: $AWS_PROFILE"
else
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
