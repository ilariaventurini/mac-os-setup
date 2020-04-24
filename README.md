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
- `brew list` non dice nulla, `node -v` non sembra esserci
- installo con brew `zsh`...
- ... mi dice che installa anche le sue dipendenze: `ncurses` e `pcre`. e poi "`ncurses` is keg-only which means bla bla bla.."
- `brew list` dice `ncurses`, `pcre`, `zsh`
- runnando `echo "$SCHELL"` mi dice `/bin/zsh` quindi la shell di default non è più `bash` ma `zsh`

### zsh

- installato
- non produce dotfiles

### oh-my-zsh

- non installato
- leggo sulla doc che serve avere installato zsh (ok) e git (ok), entrambi li ho
- lo installo usando curl (non posso con brew)
- mi ha creato dentro ilariaventurini la cartella .oh-my-zsh e il file .zshrc però mi dice anche che ci sono dei problemi di permessi e per risolverli mi basta aggiungere `ZSH_DISABLE_COMPFIX=true` all'inizio del file .zshrc, prima che oh-my-zsh sia sourceds. Lo faccio
- creo un file .aliases dentro ilariaventurini per metterci gli alias. Gli alias possono essere di bash o di zsh quindi se dovessi passare da una shell'altra dovrei metterli sia dentro .zshrc che dentro .bashsrc. Risolvo questa ripetizione creando il file .aliases, mettendoli li dentro e poi richiamandoli da dentro .zshrc (dovrei fare una cosa simile dentro .bashrc ma a me per ora non importa). Dentro .zshrc metto `source $HOME/.aliases`
- faccio una cosa similer per lo script del titolo della tab
- per fare la stessa cosa anche per la status bar di iTerm non basta creare un file in cui mettere lo script (es .iterm) ma devo anche installare `shell_integration` facendo `iTerm2 > Install Shell Integration` dal menu. Questo mi scrive un comando che lanciandolo crea un file .iterm2_shell_integration.bash. Perfetto, ora funziona ma siccme nello script mostro anche la versione di node che però non ho installato, installo node con brew
- tolgo da zsh quello che non serve (la parte di default commentata)
- installo spaceships: nella doc vedo che per installarlo serve zsh (ok) e powerlien fonts che vedo come instaòòare
- installato, ora setto un font come Menlo dentro iTerm
- installo spaceships usando oh-my-zsh, questo crea la cartella spaceship-prompt dentro .oh-my-zsh/custom/themes
- creo un symlink di spaceship.zsh-theme dentro la custom directory (leggi la doc di spaceship che si capisce)
- ora apro .zshrc e setto ZSH_THEME="spaceship"
- ora creo un file .spaceship-prompt che metto dentro una nuova cartella in dotfiles e faccio stow spaceship-prompt. Dentro questo file metto le varie impostazioni di spaceship in modo da lasciare pulito .zshrc

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

touchbar

export srtyle for github extension dark

installo le cose con brew:

- mas: no, ho usato l'app store direttamente per installare run cat
- node: c'è
- exa: installo
- git: installato
- yarn: aspetto
- zsh: installato

i seguenti non li installo con brew perchè le guide dicono di clonare il repo

- zsh-autosuggestions:
  git clone https://github.com/zsh-users/zsh-autosuggestions \${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  e aggiungi in .zshrc zsh-autosuggestions nei plugins
- zsh-completions: vedi repo, come sopra
- zsh-git-prompt: non mi serve
- zsh-history-substring-search: non mi serve
- zsh-lovers: non mi serve
- zsh-navigation-tools: non mi serve
- zsh-syntax-highlighting: git clone https://github.com/zsh-users/zsh-syntax-highlighting \${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting e metti zsh-syntax-highlighting nei plugins (non seguire istruzioni repo)

Ricapitolando:

**zsh-autosuggestions**
`git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`
Questo crea la cartella `zsh-autosuggestions` dentro `.oh-my-zsh/custom/plugins`.
Poi in .zshrc metti:

```bash
plugins=(
  ...
  zsh-autosuggestion
)
```

**zsh-completions**
`git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`
Questo crea la cartella `zsh-completions` dentro `.oh-my-zsh/custom/plugins`.
Poi in .zshrc metti:

```bash
plugins=(
  ...
  zsh-completions
)
# needed by zsh-completions plugin to reloading the completion
autoload -U compinit && compinit # questo va in fondo
```

**zsh-syntax-highlighting**
`git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting e metti`
Questo crea la cartella `zsh-syntax-highlighting` dentro `.oh-my-zsh/custom/plugins`.
Poi in .zshrc metti:

```bash
plugins=(
  ...
  zsh-syntax-highlighting
)
```

// TODO:

- readme migliore
- pc nuovo
  - unstow files
  - organizzare dotfiles
  - aggiungerli al repo
- pc lavoro
  - disintallare tutto e reinstallare con i nuovi dotfile
