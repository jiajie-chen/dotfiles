#!/bin/zsh
# region mise
if [ -n "${HOME:-}" ]
then
  eval "$(mise activate zsh --shims)"
  # For tools that resolve things via asdf
  export ASDF_DATA_DIR="${HOME}/.local/share/mise/"
fi
# endregion mise
