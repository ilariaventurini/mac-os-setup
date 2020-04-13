#!/bin/bash

#-------------------------------------
# This script creates symlinks from home directory to any desired dotfiles in ~/dotfiles
#-------------------------------------

echo "Creating symlinks from home directory to any desired dotfiles in ~/dotfiles..."

dir=~/mac-os-setup/dotfiles # dotfiles directory
olddir=~/dotfiles_old # old dotfiles backup directory

# list of files/folders to symlink in homedir
# NOTE: save dotfiles without dot, then add the dot when create the symlink
files=(
  "$dir/bash_profile" 
  "$dir/gitignore" 
)

# Create olddir in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~..."
mkdir -p $olddir
echo "...done"

# Change to the dotfiles directory
echo "Changing to the $dir directory..."
cd $dir
echo "...done"

# Move any existing dotfiles in homedir to olddir directory, then create symlinks
for file in $files; do
  echo "Moving any existing dotfiles from ~ to $olddir..."
  mv ~/.$file $olddir
  echo "Creating symlink to $file in home directory..."
  ln -s $dir/$file ~/.$file
done
echo "...done"

echo "...Creating symlinks: done"