# Mac OS setup

This repository is probably not very interesting to anyone but me.
It contains everything (or almost) that I think is necessary have on a new Mac: softwares, system settings and dotfiles.

## Install

There are things you can install using brew or scripts in general, other not.
Follow these steps.

### 1. Homebrew

Take a look at `./homebrew` content.\
Read the readme and then run the `./homebrew/install.sh` script.

### 2. ZSH

Take a look at `./zsh` content.\
Read the readme and then run the `./zsh/install.sh` script.

### 3. iTerm2

Take a look at `./iterm` content.\
Read the readme and then run the `./iterm/install.sh` script.

### 4. Git

Take a look at `./git` content.\
Read the readme and then run the `./git/install.sh` script.

### 5. VS Code

Take a look at `./vscode` content.\
Read the readme and then run the `./vscode/install.sh` script.

### 6. Macos settings

Take a look at `./macos` content.\
Read the readme and then DO NOT run the `./macos/set-defaults.sh` script.

### 7. Install manually

- [uTorrent](https://www.utorrent.com/intl/it/downloads/mac): to download torrents
- [Logitech Options](https://www.logitech.com/it-it/product/options) to use mouse MX Vertical. See settings in `./logi-options/readme.md`
- [Run cat](https://apps.apple.com/us/app/runcat/id1429033973?mt=12): the cat runs at the speed according to the CPU usage of your Mac
- Photoshop: you know. See [here](https://drive.google.com/open?id=1nBiyFOkjIfmYKfxHJfflpJaAbKjLrD0H)
- [Stylus extensions](https://chrome.google.com/webstore/detail/stylus/clngdbkpkpeebahjckkjfobafhncgmne?hl=en) in Chrome: Stylus allows you to easily install themes and skins for many popular sites. See `./chrome/extensions/readme.md`
- printer drivers

## Symlink dotfiles

At this point you should have installed everything you need, perfect.\
What we will do now is to use the dotfiles present in this repo to customize the installed applications. We will use symlinks.

Run `./make-symlinks.sh` file.
This script move each dotfiles inside a backup directory (`~/dotfiles_backup`) and create a symklink.
