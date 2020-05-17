# 🖇 iTerm

## Install

Run `install.sh` script:

```bash
cd ~/mac-os-setup/iterm
bash install.sh
```

It will:

- install iTerm2 using brew
- backup your git dotfiles:
  - `~/.iterm2_shell_integration.zsh`
  - `~/.iterm.sh`
  - `~/.zsh_history`
  - `~/Library/Preferences/com.googlecode.iterm2.plist`
- replace them with the ones in this repo and then create symlinks.

## Install manually

### Theme

To import the color theme:

- select `Preferences... -> Profiles -> Colors`
- then at the bottom right select `Color presents -> Import... -> chose ohlala.itermcolors`

### Settings

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
    - Characters considered part of a word: /-+\~\_.
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
      - \_master
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
