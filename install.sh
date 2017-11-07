#!/bin/bash
CURR_USER=$(whoami)
if [ $CURR_USER == 'root' ];then
  echo "do not run with root"
  exit 1
fi
echo "Press 'Enter' to continue"
now=$(date +%Y%m%d%H%M%S)
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" > "$HOME/Desktop/install$now.log" 2>&1
if ! which 'brew' > /dev/null 2>&1;then
  echo "could not install brew...see $HOME/Desktop/install$now.log for more details"
  exit 1
fi
sudo "$HOME/mac-setup/setup.sh" "$CURR_USER"
exit $?
