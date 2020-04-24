# VS Code

VS Code settings are inside `/Users/ilariaventurini/Library/Application Support/Code/User` in this way:

```txt
/Users/ilariaventurini/Library/Application Support/Code/User/
|_ snippets/
  |_ javascript.code-snippets
  |_ random.code-snippets
  |_ react.code-snippets
  |_ svg.code-snippets
|_ keybindings.json
|_ settings.json
```

Preferences are instead inside `/Users/ilariaventurini/Library/Preferences` so copy the file `com.microsoft.VSCode.plist` inside that folder.

If you want to know the list of the installed extensions:

```bash
# Save extensions list in ~/extensions.txt
# alias: `vscode-extensions-save`
code --list-extensions > ~/extensions.txt && echo Done!

# Install extensions listed in ~/extensions.txt
# alias: `vscode-extensions-install`
xargs -n 1 code --install-extension < ~/extensions.txt
```

## Settings

These settings should already be set having previously copied the files listed above.
Anyway, if you need them, they are:

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
  - title -> ${activeEditorLong}${separator}\${rootName}
  - integrated: renderer type -> dom
  - extensions
    - [x] Auto rename tag configuration
    - [ ] bracketpair
    - [ ] code settings sync configuration settings
      - [ ] sync: auto upload
      - [ ] sync: gist -> e1183aa8f329e949a87007e7fdff8427
    - [ ] codetour
    - [ ] emmet
    - [x] eslint
    - [ ] formatting toggle's configuration
    - [x] gistpad
    - [ ] git graph
    - [x] gitlens
    - [x] htmltagwrap
    - [x] intellisense for css class names in html
    - [ ] jake
    - [ ] javascript booster
    - [x] markdown
      - [x] markdown -> extension -> toc: github conmpatibility
    - [x] material icons
      - active icon pack -> react
    - [x] path insellisense
    - [x] prettier
      - [x] prettier: require config
    - [x] rainbow csv
    - [x] random everything configuration
    - [ ] reference search view
    - [ ] scss (Sass)
    - [x] svg
    - [x] TODO highlight
    - [x] tslint
    - [ ] typescript
      - [x] javascript -> implicit project config: experimental decorators
      - [x] javascript -> update imports on file move: enabled
      - [x] typescript -> update imports on file move: always
    - [x] visual studio live share configuration
      - liveshare: feature set -> insiders
      - liveshare: show in status bar -> while collaborating
    - [ ] vscode shader configuration
    - [x] vscode google translate
      - vscode google translate: preferred language -> en
    - [ ] vscode svg viewer configuration
    - [x] vscode-spotify configuration
      - [ ] spotify: show lyrics button
      - [ ] spotify: show mute unmute volume button
      - spotify: track info format -> artistName - trackName
      - spotify: volume up button priority -> 0