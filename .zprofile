#!/bin/zsh

# region brew
eval "$(/opt/homebrew/bin/brew shellenv)"
# endregion brew

# region vscode
export PATH="${PATH}:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
# endregion vscode

# region pyenv
# NOTE: using asdf instead
# export PYENV_ROOT="$HOME/.pyenv"
# command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"
# endregion pyenv

# region asdf
source $(brew --prefix asdf)/libexec/asdf.sh
# endregion asdf

# region Docker M1
# NOTE: this breaks minikube when trying to use amd64 by default
# export DOCKER_DEFAULT_PLATFORM=linux/amd64
# NOTE: this should be default if not specified on M1
# export DOCKER_DEFAULT_PLATFORM=linux/arm64
# endregion Docker M1
