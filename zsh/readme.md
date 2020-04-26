# ZSH & Co

## ZSH

When you start a terminal application, whether it be on your server or your local computer, it is running a shell called _Bash_. _Bash_ is by far the most popular shell and comes with pretty much every UNIX-based operating system. There are, however, alternatives to _Bash_ that make using the terminal faster and more comfortable for web developers.

One of the most popular shells with web developers is the _Z shell_, or **ZSH**.
_ZSH_ is an extended version of the _Bash_ with plenty of new features and support for plugins and themes.

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

Run `install.sh` script. It will install:

- zsh
- oh-my-zsh
- zsh-autosuggestions plugin
- zsh-completions plugin
- zsh-syntax-highlighting plugin
- spaceships-prompt theme

If you want to add o remove something, change the script.
