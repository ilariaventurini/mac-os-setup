# Mac OS setup

This repository is probably not very interesting to anyone but me.
It contains everything (or almost) that I think is necessary have on a new Mac: softwares, system settings and dotfiles.

## Install stuff

```bash
bash ./main.sh
```

## Install manually

- **uTorrent: to donwload things**
- **logitech options: for mouse MX vertical**
- **cat run: the cat living in the menubar runs at the speed according to the CPU usage**
- photoshop: you know
- printer drivers

## Thanks to

Most of commands taken from:

- https://github.com/mathiasbynens/dotfiles
- https://github.com/tech-otaku/macos-config-catalina

## TODO:

- test script
- Git fork settings
- dotfiles
  - temi
  - zsh
  - spaceship
  - vscode
  - iterm

## Notes

### brew

- non installato
- quando vai per installarlo dice che installa cose dentro /usr/local/...
- / è Machintosh
- /usr contiene: bin/, lib/, libexec/, local/, sbin/, share/, standalone/, X11, X11R6
- /Users contiene ilariaventurini e Shared
- ok, prima di installare brew, dentro /usr/local/ non c'è assolutamente nulla
- installato! Ha effettivamente messo tutto dentro /usr/local/ che ora contiene diverse cartelle:
  - /usr/local/bin
  - /usr/local/Caskroom
  - /usr/local/Cellar
  - /usr/local/etc
  - /usr/local/Frameworks
  - /usr/local/Homebrew
  - /usr/local/include
  - /usr/local/lib
  - /usr/local/opt
  - /usr/local/sbin
  - /usr/local/share
  - /usr/local/var

### stow

installo stow con brew e sposto i dotfiles dentro la cartella ilariaventurini/dotfiles (che creo).
Dentro dotfiles creo diverse cartelle, una per ogni programma, es:

dotfiles/iterm
dotfiles/zsh
dotfiles/oh-my-zsh
dotfiles/scrips // per gli script generici come .aliases

ora sposto dentro ogni cartella i dotfiles di riferimento, così come sono, senza modificare la strutttura.

Ora quindi ilariaventurini/ non ha più i singoli dotfiles

apro il Terminare, e vado dentro dotfiles, poi lancio il comando `stow iterm`, `stow zsh`, .. uno per ogni cartella. Questo mi crea dei symlink dentro ilariaventurini con la struttura originale. Quindi ora ilariaventurini è "disordinata" ma i dotfiles sono in realtà ben organizzati dentro dotfiles e posso modificare quelli quando mi serve

### macos

Provo a lanciare macos-sh ma ha dei problemi con i permessi e non va quindi lancio i comandi uno a uno, alcuni vanno ma altri no. Poi riavvio e funziona!

configuro spaceshipt come mi piace
segnarsi tutte le cose che funzionano del maco-setting, quelle che no, quelle che non mi piacciono (green, key repeat mettere 5 e 9) e quelle che mancano
setto lo zoom ^+scroll
setto a false defaults write com.apple.finder ShowPreviewPane -bool false

TODO:

- touchbar
