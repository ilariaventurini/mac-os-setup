#!/bin/bash

#-------------------------------------
# Install things from App Store using `mas`.
# To see the ids, run `mas list`
#-------------------------------------

echo "Installing RunCat..."

mas install 1429033973 # RunCat (7.3)

# Install all pending updates
mas upgrade

echo "...done"