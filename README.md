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
- git: aspetto
- yarn: aspetto
- zsh: installato

i seguenti non li installo con brew perchè le guide dicono di clonare il repo
- zsh-autosuggestions: 
 git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
e aggiungi in .zshrc zsh-autosuggestions nei plugins
- zsh-completions: vedi repo, come sopra
- zsh-git-prompt: non mi serve
- zsh-history-substring-search: non mi serve
- zsh-lovers: non mi serve
- zsh-navigation-tools: non mi serve
- zsh-syntax-highlighting: git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting e metti zsh-syntax-highlighting nei plugins (non seguire istruzioni repo)

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
`git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting e metti `
Questo crea la cartella `zsh-syntax-highlighting` dentro `.oh-my-zsh/custom/plugins`.
Poi in .zshrc metti:

```bash
plugins=(
  ...
  zsh-syntax-highlighting
)
```

## Git Fork
Preferences:
- General
  - Default  source Folder: accurat
  -  Diff view: /
  -  Sort commits: Topologically
  -  [ ] Automatically push on commit  
  -  [x] Fetch remotes automatically
  -  [x] Tab indicator for uncommitted changes
  -  [ ] Update submodules automatically
  -  [ ] Disable syntax highlight
  -  [x] Use old toolbar style (with labels)
  -  [x] Remember checkout state in create  brach dialog
  -  [x] Always  use dark theme
- Commit
  - Commit subject: Low limit 50, high limit 70
  - [x] Check spelling as you  type  in commit message
  - [ ] Use monospace font in commit description
- Git
- Integration
  - Terminal client: iterm
  - Merge tool: fileMerge
  - External diff tool: fileMerge
  - Default bitbucket tool: Fork.app
  - Default github tool: Fork.app
  - [x] hightlight bugtracker links in commit messagges
  - command line:  fork cli v4 installed
- Custom commands
- Updates
  - [x] Automatically check for updates
  - [ ] Automatically download  updates
  - Update interval: Daily
  - [x] Send anonymous statistics about features you see

Right click on toolbar 
- [x] Icon and text
- [ ] icon only
- [ ] text only
- [x] use small size
- Customize toolbar... Left -> right
  - Quick launch
  - Fetch, pull, push
  - stash
  - create new branch
  - space
  - repository status
  - space
  - refresh
  - open in
  - leave feedback
  - search

## Iterm temi e impostazioni
Preferences:
- General
  - Startup
    - window restoration policy: Use system window restoration setting
    - [ ] open profiles window
  - Closing
    - [ ] Quit when all windows are closed
    - [x] Confirm closing multiple sessions
    - [ ] Confirm quit iTerm 2
    - [ ] Even if there are no windows
  - Magic
    - instant replay uses 4 MB per session
    - [x] save copy/paste and command history to disk
    - [ ] enable python api
    - [x] GPU rendering
  - Services
    - [ ] add bonjour hosts to profiles
    - [x] check for updates automatically
    - [ ] update to beta test releases
  - Selection
    - [x] copy to pasteboard on selection
    - [ ] copied text includes trailing newline
    - [ ] applications in terminal may access clipboard
    - [ ] double-click performs smart selection
    - [x] triple-click selects entire wrapped lines
    - Characters considered part of a word: /-+\~_.
  - Window
    - [ ] smart window placement
    - [x] adjust window when changing font size
    - [ ] zoom maximizes vertically only
    - [x] native full screen windows
    - [x] separate window title per tab
  - Preferences
    - [ ] load preferences from a custom folder or URL
    - [ ] Save changes to folder when iterm2 quits
  - tmux
    - Open tmux windows as: Native windows
    - [ ] automatically bury the tmux client session after connecting
    - [x] use tmux profile rather than profile of the connecting session
    - [x] status bar shows tmux status bar content, not native components
- Appearance
  - General
    - Theme: Compact
    - Tab bar location: Top
    - Status bar location: Bottom
    - [x] auto-hide menu bar in non native fullscreen
    - [ ] exlclude from dock and ...
  - Windows
    - [ ] show window number in title bar
    - [x] show border around window
    - [ ] hide scrollbars
    - [ ] disable transparency for fullscreen windows by default
    - [x] show line under title bar when the tab bar is not visible
    - [x] show proxy icon in window title bar
  - Tabs
    - [x] show tab bar even when there is only on tab
    - [ ] show tab numbers
    - [x] tabs have close buttons
    - [x] show activity indicator
    - [x] show new output indicator
    - [x] show tab bar in fullscreen
    - [ ] stretch tabs to fill bar
  - Panes
    - [ ] show per pane title bar with split pane
    - [ ] separate status bars per pane
    - [x] separate background images per pane
  - Dimming
    - dimmin amount: 0
    - [x] dim inactive split panes
    - [ ] dim background windows
    - [ ] dimming affects only texts, not background
- Profiles
  - General
    - Title: Name (job)
    - [x] applications in terminal may change the title
    - icon: no icon
    - Command: login shell
    - working directory: advanced configuration
      - Working directory for new windows: home directory
      - working directory for new tabs: home directory
      - working directory for new split panes: reuse previous session's directory
  - Colors
    - ohlala
  - Text
    - cursor: vertical bar
    - [x] blinking cursor
    - [x] draw bold text in bold font
    - [ ] blinking text
    - [x] italic text
    - [ ] use builtin powerline glyphs
    - [ ] enable subpixel antialiasing
    - [x] use unicode version 9+ widths
    - [x] ambiguous characters are double-width
    - unicode normalization form: none
    - font: MesloLGS NF, Regular, 14, 100, 100
    - [ ] use ligatures
    - [x] anti-aliased
    - [ ] use a different font for non-ASCII text
  - Window
    - transparency: 0
    - blending: 50%
    - columns: 80, rows: 25
    - style: normal
    - screen: no preference
    - space: current space
    - [ ] hide after opening
    - [ ] open toolbelt
    - [ ] custom window title: /
    - [ ] force this profile to always open in a new window never in a tab
    - [x] use transparency
  - Terminal
    - scrollback lines: 1000
    - [ ] unlimited scrollback
    - [ ] save lines to scrollback when an app status bar is present
    - [x] save lines to scrollback in alternate screen mode
    - [x] enable mouse reporting
    - [x] report mouse wheel events
    - [x] terminal may report window title
    - [x] terminal may enable paste bracketing
    - [ ] disable session-initiated printing
    - [ ] disable save/restore alternate screen
    - [x] disable session-initiated window resizing
    - [ ] silence bell
    - [ ] flash visual bell
    - [x] notification center alerts
    - [x] show bell icon in tabs
    - [x] set locale variables automatically
    - [x] insert newline before start of command prompt if needed
    - [ ] show mark indicators
  - Session
    - after a session ends: close
    - undo can revive a session that has been closed for up to 5 seconds
    - prompt before closing? never
    - rlogin / ssh / slogin / telnet
    - [ ] when idle, send ASCII code
    - [ ] avoid repainting while cursor is hidden to reduce flicker while scrolling
    - [x] status bar enabled
      - \(user.pwd)
      - CPU
      - RAM
      - \(user.nodeVersion)
      - _master
  - Keys
  - Advances
- Keys
- Arrangements
- Pointer
  - General
    - [x] click opens filename/URL (semantic history)
    - [ ] click reported to apps, does not open menu
    - [x] click moves cursor
    - [ ] three-finger tap emulates middle click
    - [ ] focus follows mouse
- Advanced

## VSCODE

Preferences
- Settings
  - editor: font size -> 12
  - [x] lightbulb: enabled
  - tab completion -> on
  - tab size -> 2
  - [x] format on past
  - [x] format on save
  - [x] format on type
  - [ ] minimap enabled
  - color theme -> ohlala
  - icon theme -> material-icon-theme
  - [ ] enable preview from quick open
  - label format -> short
  - title -> ${activeEditorLong}${separator}${rootName}
  - integrated: renderer type -> dom
  - extensions
    - Auto rename tag configuration
    - bracketpair
    - code settings sync configuration settings
      - [ ] sync: auto upload
      - [ ] sync: gist -> e1183aa8f329e949a87007e7fdff8427
    - codetour
    - CSS
    - emmet
    - eslint
    - formatting toggle's configuration
    - gistpad
    - git
      - [x] enabled
    - git graph
    - gitlens
    - grunt
    - gulp
    - HTML
    - htmltagwrap
    - intellisense for css class names in html
    - jake
    - javascript booster
    - json
    - less
    - markdown
      - [x] markdown -> extension -> toc: github conmpatibility
    - material icons
      - active icon pack -> react
    - merge conflict
    - microsoft account
    - node debug
    - npm
    - path insellisense
    - php
    - prettier
      - [x] prettier: require config
    - rainbow csv
    - random everything configuration
    - reference search view
    - scss (Sass)
    - svg
    - TODO highlight
    - tslint
    - typescript
      - [x] javascript -> implicit project config: experimental decorators
      - [x] javascript -> update imports on file move: enabled
      - [x] typescript -> update imports on file move: always
    - visual studio live share configuration
      - liveshare: feature set -> insiders
      - liveshare: show in status bar -> while collaborating
    - vscode shader configuration
    - vscode google translate
      - vscode google translate: preferred language -> en
    - vscode svg viewer configuration
    - vscode-spotify configuration
      - [ ] spotify: show lyrics button
      - [ ] spotify: show mute unmute volume button
      - spotify: track info format -> artistName - trackName
      - spotify: volume up button priority -> 0

- Online services settings -> /
- Extensions -> vedi sopra
- Keyboard shortcuts -> keybindings.json
- Keymaps -> /
- User snippets -> ...code-snippets
- Color theme -> ohlala (horizon, panda syntax, lucy, yoncè)
- File icon theme -> material icon theme
