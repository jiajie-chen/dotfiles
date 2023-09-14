#!/bin/zsh

# region zprofile
if [ -f ~/.zprofile ]
then
  source ~/.zprofile
fi
# endregion zprofile

# region starship
if type starship &>/dev/null
then
  eval "$(starship init zsh)"
fi
# endregion starship

# region zsh-autosuggestions
# TODO: if/then
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
bindkey '^[[Z' autosuggest-accept
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

# region direnv
if type direnv &>/dev/null
then
  eval "$(direnv hook zsh)"
fi
# endregion direnv

# region lsd
if type lsd &>/dev/null
then
  alias ls='lsd'
fi
# endregion lsd

# region Rancher Desktop
# export PATH="/Users/jchen/.rd/bin:$PATH"
# endregion Rancher Desktop
