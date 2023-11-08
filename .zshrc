#!/bin/zsh

# region zprofile
# NOTE: probably unneeded, as it will call it twice on MacOS
#if [ -f ~/.zprofile ]
#then
#  source ~/.zprofile
#fi
# endregion zprofile

# region autoload
autoload -Uz compinit
compinit
autoload -U bashcompinit
bashcompinit
# endregion autoload

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

# region pipx
if type pipx &>/dev/null
then
  eval "$(register-python-argcomplete pipx)"
fi
# endregion pipx

# region Rancher Desktop
export PATH="$PATH:/Users/jchen/.rd/bin"
# endregion Rancher Desktop

# region Aliases
# TODO: handle error when not in repo
# alias cdgr='pushd "$(git rev-parse --show-toplevel)"'
# endregion Aliases

# region kubectl
if type kubectl &>/dev/null
then
  source <(kubectl completion zsh)
fi
# endregion kubectl

# region k9s
if type k9s &>/dev/null
then
  source <(k9s completion zsh); compdef _k9s k9s
fi
# endregion k9s

# region Local Scripts
export PATH="/Users/jchen/.local/bin:$PATH"
# endregion Local Scripts
