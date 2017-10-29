#!/bin/bash
CURR_USER=$(whoami)
if [ $CURR_USER == 'root' ];then
  echo "do not run with root"
  exit 1
fi
sudo "$HOME/mac-setup/setup.sh" "$CURR_USER"
exit $?
