# Homebrew

# Install 

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"`

Check that everything is ok: `brew --version`.

Now `/usr/local/` should contain:

- `/usr/local/bin`
- `/usr/local/Caskroom`
- `/usr/local/Cellar`
- `/usr/local/etc`
- `/usr/local/Frameworks`
- `/usr/local/Homebrew`
- `/usr/local/include`
- `/usr/local/lib`
- `/usr/local/opt`
- `/usr/local/sbin`
- `/usr/local/share`
- `/usr/local/var`

Take a look at `install.sh`. It uses brew to install some software you need but not run it at all. Run the commands you need.
