#!/usr/bin/bash
# shellcheck disable=SC1091

## START pyenv
export PATH="/home/jiajie-chen/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
## END pyenv

## START asdf
source "$HOME/.asdf/asdf.sh"
source "$HOME/.asdf/completions/asdf.bash"
## END asdf

## START pipx
eval "$(register-python-argcomplete pipx)"
## END pipx

## START direnv
eval "$(direnv hook bash)"
## END direnv

## START rust
source "$HOME/.cargo/env"
## end rust

## START starship
eval "$(starship init bash)"
## END starship

## START lsd
alias ls='lsd'
## END lsd
# start .NET core
export PATH="$PATH:/home/jiajie-chen/.dotnet/tools"
# end .NET core
