# 🏷 Git

## ⚙️ Install

Run `install.sh` script:

```bash
cd ~/mac-os-setup/git
bash install.sh
```

It will:

- install Git using brew
- backup your git dotfiles:
  - `~/.gitconfig`
  - `~/.gitignore_global`
- replace them with the ones in this repo and then create symlinks.
