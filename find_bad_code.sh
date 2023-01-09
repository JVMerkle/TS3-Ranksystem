#!/bin/bash
set +e

retVal=0

err() {
  echo "$1 detected in $F"
  echo '------------------------------------'
  retVal=1
}

alias grep='grep --line-number --ignore-case -E'

while read -r F; do

  grep "eval[ |\t]*\(.+\)" "$F" && err Eval
  grep "curl" "$F" && err Curl
  grep "file_get_contents" "$F" && err file_get_contents
  grep "shell_exec" "$F" && err shell_exec

done < <(find . -iname "*.php" -not -path './.git/*' -not -path './find_bad_code.sh' -type f)

exit $retVal
