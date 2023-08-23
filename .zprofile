#!/bin/zsh

# region brew
eval "$(/opt/homebrew/bin/brew shellenv)"
# endregion brew

# region vscode
export PATH="${PATH}:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
# end region vscode

# region pyenv
# export PYENV_ROOT="$HOME/.pyenv"
# command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"
# endregion pyenv

# region asdf
source $(brew --prefix asdf)/libexec/asdf.sh
# endregion asdf
