# ZSH & Co

## ZSH

When you start a terminal application, whether it be on your server or your local computer, it is running a shell called _Bash_. _Bash_ is by far the most popular shell and comes with pretty much every UNIX-based operating system. There are, however, alternatives to _Bash_ that make using the terminal faster and more comfortable for web developers.

One of the most popular shells with web developers is the _Z shell_, or **ZSH**.
_ZSH_ is an extended version of the _Bash_ with plenty of new features and support for plugins and themes.

### Install
https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH

Install `zsh` running: `bre install zsh`. Doing so it install also dependencies `ncurses` and `pcre`.
After that if you run `brew list`, you should be able to see `ncurses`, `pcre`, `zsh`.
Than you have to change you refault shell from `bash` to `zsh` you can yse the command `chsh -s` (change shell):

```bash
chsh -s $(which zsh) # change the default shell to Zsh
```

Other useful commands are:

```bash
which zsh # this gives you your path to zsh
chsh -s /bin/bash # change the default shell to bash
chsh -s /bin/zsh # change the default shell to zsh
cat /etc/shells # you can see a list of included shells you can select
echo $SCHELL # return the current shell (expected result: /bin/zsh or similar)
$SHELL --version # expected result: zsh 5.4.2 or similar
zsh --version # expected result: zsh 5.4.2 or more recent
```

zsh do not produce dotfiles, for the moment.

## Oh my zsh

### What is Oh My Zsh and what does it have to do with zsh?

_Zsh_ is a [shell](https://en.wikipedia.org/wiki/Shell_(computing)), just like [_bash_](https://www.gnu.org/software/bash/) or [_fish_](https://fishshell.com/), which interprets commands and runs them.
**Oh My Zsh** is a framework built on top of zsh that is structured to allow it to have plugins and themes, as well as providing what we think are the best settings from the start. You can use _zsh_ without _Oh My Zsh_, but you can't use _Oh My Zsh_ if you don't have _zsh_.

### What is a zsh plugin?

A **_zsh_ plugin** is, on its most basic form, just a shell script that can be interpreted by _Zsh_. So, in its essence, it can do anything that you could do run line by line in your terminal. A _plugin_ can also provide completion for certain commands and functions.

### What is a zsh theme?

A **_zsh_ theme** is a _zsh_ script that changes the _prompt_.
The **prompt** is the line (or lines, on multiline themes) that appear every time you want to run a command. This is ultimately accomplished by changing the `$PROMPT` variable. But a theme can do much more than that, like adding an automatic _git status prompt_ that changes each time the _prompt_ is redrawn, or a clock that is refreshed per-second, or many other functionalities like that. Browse the [Themes](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes) page to find one that you like.

NOTE: a _zsh_ theme can't change the appearance of your terminal emulator. This includes things like the color scheme or the character font. Those are separate settings that need to be configured in your terminal emulator settings.

### What is the .zshrc file?

The **.zshrc** file (or just _zshrc file_) is a file that _zsh_ reads when it starts. It can be found in your home directory, which will change depending on the system and platform you're using. On a terminal, the path to the home directory can be found by running `echo $HOME`.

### Install
https://github.com/ohmyzsh/ohmyzsh

`zsh`, `git` and `curl` should be installed. Do a check:

```bash
zsh --version
git --version
curl --version
```

You can install _oh-my-zsh_ via the command-line with curl:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Inside the `/ilariaventurini` folder you should have `.oh-my-zsh` and `.zshrc`.

If the previous command say that there are some permission issues:

- open `.zshrc`
- add `ZSH_DISABLE_COMPFIX=true` at the start of the file, before that _oh-my-zsh_ is sourceds.

### Customization

#### Plugins

##### zsh-autosuggestions

`git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`

This command creates the folder `zsh-autosuggestions` inside `.oh-my-zsh/custom/plugins`.
Change `.zshrc` adding:

```txt
plugins=(
  ...
  zsh-autosuggestion
)
```

##### zsh-completions

`git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`

This command creates the folder `zsh-completions` inside `.oh-my-zsh/custom/plugins`.
Change `.zshrc` adding:

```txt
plugins=(
  ...
  zsh-completions
)
# needed by zsh-completions plugin to reloading the completion
autoload -U compinit && compinit # at the end of the file
```

##### zsh-syntax-highlighting

`git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`

This command creates the folder `zsh-syntax-highlighting` inside `.oh-my-zsh/custom/plugins`.
Change `.zshrc` adding:

```txt
plugins=(
  ...
  zsh-syntax-highlighting
)
```

#### Theme

Install [`spaceships-prompt`](https://github.com/denysdovhan/spaceship-prompt).

##### Install

To work correctly, you will first need `zsh` and a [`Powerline Font`](https://github.com/powerline/fonts) used in your terminal (for example use Menlo in iTerm2).

Now, to install `spaceships-prompt` use _oh-my-zsh_:

- clone this repo: `git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"`
- the previous command creates the folder `spaceship-prompt` inside `.oh-my-zsh/custom/themes`

- creates a symlink of spaceship.zsh-theme to your oh-my-zsh custom themes directory: `ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"`

- set `ZSH_THEME="spaceship"` in your `.zshrc`.
