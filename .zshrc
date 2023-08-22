#!/bin/zsh

if [ -f ~/.bash_profile ]; then
    source ~/.bash_profile
fi

# region starship
eval "$(starship init zsh)"
# endregion starship

# region zsh-autosuggestions
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
# endregion zsh-autosuggestions

# region brew-autocomplete
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  autoload -Uz compinit
  compinit
fi
# endregion brew-autocomplete

# region gpg
export GPG_TTY=$(tty)
# endregion gpg
