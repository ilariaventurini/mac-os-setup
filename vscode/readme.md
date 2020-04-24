## VS Code

Vs code setttings are inside `/Users/ilariaventurini/Library/Application Support/Code/User` in this way:

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

If you want to know the list of the installed extensions:

```bash
# Save extensions list in ~/extensions.txt
# alias: `vscode-extensions-save`
code --list-extensions > ~/extensions.txt && echo Done!

# Install extensions listed in ~/extensions.txt
# alias: `vscode-extensions-install`
xargs -n 1 code --install-extension < ~/extensions.txt
```
