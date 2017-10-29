#!/bin/bash
#do not run this script directly; run install.sh as normal user
#this directory is only present via git clone. Must be clone to home directory
setup_dir="$HOME/mac-setup"
binfiles_dir="$setup_dir/binfiles"
dotfiles_dir="$setup_dir/dotfiles"
vimfiles_dir="$setup_dir/vimfiles"
plistfies_dir="$setup_dir/plistfiles"
bin_install_dir="/usr/local/bin"
vim_home_dir="$HOME/.vim"
vim_ftplugin_dir="$vim_home_dir/ftplugin"
ohmyzsh_dir="$HOME/.oh-my-zsh"
CURR_USER="$1"
if [ -z "$CURR_USER" ];then
  echo "could not get current user"
  exit 1
fi
if [ ! -d "$setup_dir" ];then
  echo "could not find setup directory"
  exit 1
fi

if [ ! -d "$bin_install_dir" ];then
  mkdir -p "$bin_install_dir" > /dev/null 2>&1
  if [ $? -ne 0 ];then
    echo "could not create $bin_install_dir"
    exit 1
  fi
fi
echo "installing binfiles"
for binfile in "$binfiles_dir"/*;do
  if [ -e "$binfile" ];then
    binname="${binfile##*/}"
    if [ -e "$bin_install_dir/$binname" ];then
      rm -f "$bin_install_dir/$binname" > /dev/null 2>&1
      if [ $? -ne 0 ];then
	echo "could not remove old $binname. Perhaps incorrect permissions...run with root"
	exit 1
      fi
    fi
    cp -a "$binfile" "$bin_install_dir" > /dev/null 2>&1
    if [ $? -ne 0 ];then
      echo "could not install $binfile. Perhaps incorrect permissions...run with root"
      exit 1
    fi
  fi
done
echo "installing dotfiles"
for dotfile in "$dotfiles_dir"/.*;do
  if [ -f "$dotfile" ];then
    dotname="${dotfile##*/}"
    if [ -L "$HOME/$dotname" ] || [ -f "$HOME/$dotname" ];then
      rm -f "$HOME/$dotname"
      if [ $? -ne 0 ];then
	echo "could not remove old $dotfile" > /dev/null 2>&1
	exit 1
      fi
    fi
    ln -s "$dotfile" "$HOME" > /dev/null 2>&1
    if [ $? -ne 0 ];then
      echo "could not create alias of $dotfile"
      exit 1
    fi
  fi
done
echo "installing plistsfiles"
for plist in "$plistfies_dir"/*;do
  if [ -f "$plist" ];then
    plistname="${plist##*/}"
    if [ -L "$HOME/$plistname" ] || [ -f "$HOME/$plistname" ];then
      rm -f "$HOME/$plistname" > /dev/null 2>&1
      if [ $? -ne 0 ];then
	echo "could not remove old plist $plistname"
	exit 1
      fi
    fi
    ln -s "$plist" "$HOME" > /dev/null 2>&1
    if [ $? -ne 0 ];then
      echo "could not create alias of $plist"
      exit 1
    fi
  fi
done
echo "installing vimfiles"
if [ -d "$vim_home_dir" ];then
  rm -rf "$vim_home_dir" > /dev/null 2>&1
  if [ $? -ne 0 ];then
    echo "could not remove vim old directory"
    exit 1
  fi
fi
if [ ! -d "$vim_home_dir" ];then
  mkdir -p "$vim_home_dir" > /dev/null 2>&1
  if [ $? -ne 0 ];then
    echo "could not create vim directory"
    exit 1
  fi
  mkdir -p "$vim_ftplugin_dir" > /dev/null 2>&1
  if [ $? -ne 0 ];then
    echo "could not create vim ftplugin directory"
    exit 1
  fi
fi
for vimfile in "$vimfiles_dir"/*;do
  if [ -f "$vimfile" ];then
    vimname="${vimfile##*/}"
    if [ -L "$vim_ftplugin_dir/$vimname" ];then
      rm -f "$vim_ftplugin_dir/$vimname" > /dev/null 2>&1
      if [ $? -ne 0 ];then
	echo "could not remove old $vimname"
	exit 1
      fi
    fi
    ln -s "$vimfile" "$vim_ftplugin_dir" > /dev/null 2>&1
    if [ $? -ne 0 ];then
      echo "could not create alias of $vimfile"
      exit 1
    fi
  fi
done
git clone https://github.com/VundleVim/Vundle.vim.git "$vim_home_dir/bundle/Vundle.vim"
vim +PluginInstall +qall
echo "installing ohmyzsh"
if [ -d "$ohmyzsh_dir" ];then
  rm -rf "$ohmyzsh_dir" > /dev/null 2>&1
  if [ $? -ne 0 ];then
    echo "could not remove ohmyzsh old directory"
    exit 1
  fi
fi
if [ -f "$HOME/.zshrc.pre-oh-my-zsh" ];then
  rm -f "$HOME/.zshrc.pre-oh-my-zsh" > /dev/null 2>&1
fi
if [ -f "$HOME/.zshrc" ] || [ -L "$HOME/.zshrc" ];then
  rm -f "$HOME/.zshrc" > /dev/null 2>&1
fi
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
if [ -f "$HOME/.zshrc.pre-oh-my-zsh" ];then
  rm -f "$HOME/.zshrc.pre-oh-my-zsh" > /dev/null 2>&1
fi
if [ -f "$HOME/.zshrc" ] || [ -L "$HOME/.zshrc" ];then
  rm -f "$HOME/.zshrc" > /dev/null 2>&1
fi
#ln -s "$dotfiles_dir/.zshrc" "$HOME" > /dev/null 2>&1
sudo -u "$USER" cat << EOF > "$HOME/.zshrc"
export ZSH=/Users/$CURR_USER/.oh-my-zsh
ZSH_THEME="darkblood"
plugin=(git)
source \$ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8
export EDITOR='vim'
export SSH_KEY="$HOME/.ssh/rsa_id"
PATH=:$PATH
EOF
echo "done"
exit 0
