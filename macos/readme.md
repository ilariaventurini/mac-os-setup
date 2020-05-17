# 💻 Mac OS settings

Run `set-defaults.sh` script to setup some macos settings:

```bash
cd ~/mac-os-setup/macos

# run the script saving the output both on console and in a txt file
bash set-defaults.sh 2>&1 | tee ~/mac-os-setup-backup/macos/set-defaults-results_$(date +%Y-%m-%d_%H%M%S).txt
```

Everytime you run the script, a backup is made. Check it in `~/mac-os-setup-backup/macos/`.

Some settings are not set by the script but the value of each setting is printed so run the script and manually check  what has been set and what has been not set.

## Set manually

In addition to the settings not set by the script, be sure to also set the following things:

### Customise toolbar

- [x] Show: Icon only
- From left to right:
  - Back/Forward
  - Space
  - View
  - Path
  - Group
  - Share
  - Edit tags
  - New folder
  - Delete
  - Get info
  - Quick look
  - Search

### Status bar

From left to right:

- SpotMenu
- Sip
- RunCat
- Backup and sync from Google
- WiFi
- Bluetooth
- Battery
- Sound
- Date
- Hour
- Search
- Notificarion

### Dock

From left to right:

- Finder
- Google Chrome
- Visual Studio Code
- Spotify
- iTerm
- WhatsApp
- Fork

### iTunes

- Stop iTunes from responding to the keyboard media keys
