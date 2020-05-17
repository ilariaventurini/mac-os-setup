# Mac OS setup

This repository is probably not very interesting to anyone but me.
It contains everything (or almost) that I think is necessary have on a new Mac: softwares, system settings and dotfiles.

## Install and create symlinks

Read the readme files and run these scripts:

- `./homebrew/install.sh`
- `./zsh/install.sh`
- `./iterm/install.sh`
- `./git/install.sh`
- `./fork/install.sh`
- `./vscode/install.sh`
- `./macos/set-defaults.sh`

Each script:
- makes a backup of the current dotfiles
- installs things
- creates symlinks in order to use the dotfiles present in this repo to customize the installed applications.

**NOTE: Revert**: If you want to revert the symlink process, you have to remove the symlinks created and replace them with the old dotfiles that are now in `~/mac-os-backup/`.

**NOTE: Changes**: When a dotfiles is updated, you should commit changes and push it. Then pull it in the other machines and everything should go fine.
If you creates new dotfiles, add them to the repo, remember to add also references in the related `./install.sh` script and run it in the other machines.

## Install manually

Unfortunately you have to install some things manually:

- [uTorrent](https://www.utorrent.com/intl/it/downloads/mac): to download torrents
- [Logitech Options](https://www.logitech.com/it-it/product/options) to use mouse MX Vertical. See settings in `./logi-options/readme.md`
- [Run cat](https://apps.apple.com/us/app/runcat/id1429033973?mt=12): the cat runs at the speed according to the CPU usage of your Mac
- Photoshop: you know. See _GDrive - Photoshop/_
- [Stylus extension](https://chrome.google.com/webstore/detail/stylus/clngdbkpkpeebahjckkjfobafhncgmne?hl=en) in Chrome: Stylus allows you to easily install themes and skins for many popular sites. See `./chrome/extensions/readme.md`
- printer drivers.
