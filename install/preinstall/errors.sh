#!/bin/bash

catch_errors() {
  echo -e "\n\e[31mInstallation failed!\e[0m"
  echo
  echo "This command halted with exit code $?:"
  echo "$BASH_COMMAND"
  echo
  echo "welp shit broke"

  echo "You can retry by running: bash ~/.local/share/calos/install.sh."
  echo "Feel free to use nano to edit any files you think may be the culprit."
}

trap catch_errors ERR
