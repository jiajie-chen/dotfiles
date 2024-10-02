#!/bin/zsh
# zmodload zsh/zprof
typeset -U path PATH

# region brew
readonly brew_prefix="/opt/homebrew"
eval "$(${brew_prefix}/bin/brew shellenv)"
# endregion brew

# region asdf
#source "${brew_prefix}/opt/asdf/libexec/asdf.sh"
# endregion asdf

# region mise
if [ -n "${HOME:-}" ]
then
  path=("${HOME}/.local/share/mise/shims" $path)
  # For tools that resolve things via asdf
  export ASDF_DATA_DIR="${HOME}/.local/share/mise/"
fi
# endregion mise

# region brew-autocomplete
if type brew &>/dev/null
then
  fpath+=("${brew_prefix}/share/zsh/site-functions")
fi
# endregion brew-autocomplete

# region compinit
autoload -Uz compinit bashcompinit
compinit
bashcompinit
# endregion compinit

# region pipx
# if type pipx &>/dev/null
# then
#   eval "$(register-python-argcomplete pipx)"
# fi
# endregion pipx

# region kubectl
# NOTE: this takes a long time, possibly due to asdf shims
# if type kubectl &>/dev/null
# then
#   source <(kubectl completion zsh)
# fi
# endregion kubectl

# region k9s
# if type k9s &>/dev/null
# then
#   source <(k9s completion zsh); compdef _k9s k9s
# fi
# endregion k9s

# region zsh-autosuggestions
source "${brew_prefix}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
ZSH_AUTOSUGGEST_STRATEGY=(completion history)
# bindkey '^[[Z' autosuggest-accept
# endregion zsh-autosuggestions

# region starship
if type starship &>/dev/null
then
  eval "$(starship init zsh)"
fi
# endregion starship

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
# NOTE: placed as last priority on PATH, to avoid overriding existing
if [ -n "${HOME:-}" ] && [ -d "${HOME}/.rd/bin" ]
then
  path=($path "${HOME}/.rd/bin")
fi
# endregion Rancher Desktop

# region Pipenv
# if type pipenv &>/dev/null
# then
#   PIPENV_SKIP_LOCK=1
# fi
# endregion Pipenv

# region vscode
path=($path '/Applications/Visual Studio Code.app/Contents/Resources/app/bin')
# endregion vscode

# region gnu-sed
path=("${brew_prefix}/opt/gnu-sed/libexec/gnubin" $path)
# endregion gnu-sed

# region Local Scripts
if [ -n "${HOME:-}" ] && [ -d "${HOME}/.local/bin" ]
then
  path=("${HOME}/.local/bin" $path)
fi
# endregion Local Scripts

export PATH
# zprof
