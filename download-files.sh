#!/bin/bash

#-------------------------------------
# Download Logitech Options for Mouse MX vertical
#-------------------------------------

echo "Downloading Logitech Options..."

# downloading zip
curl -o ~/Downloads/LogitechOptions.zip -L https://download01.logi.com/web/ftp/pub/techsupport/options/Options_8.10.64.zip

# unzip
cd ~/Downloads
unzip -o ~/Downloads/LogitechOptions.zip

echo "...done"

#-------------------------------------
# Download uTorrent web
#-------------------------------------

echo "Downloading uTorrent web..."

# downloading file
curl -o ~/Downloads/uTorrent.pkg -L https://utweb-assets.bittorrent.com/installer/uTorrentWebInstaller.pkg

echo "...done"