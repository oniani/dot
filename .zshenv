# zsh configuration file
# by David Oniani <onianidavid@gmail.com>
# MIT License

# XDG base directory specification
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Move to ~/.cache
export NPM_CONFIG_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}"/npm

# Move to ~/.config
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/inputrc
export IPYTHONDIR="${XDG_CONFIG_HOME:-$HOME/.config}"/ipython
export JUPYTER_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"/jupyter
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}"/wget/wgetrc
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}"/zsh

# Move to ~/.local/share
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"/cargo
export GNUPGHOME="${XDG_DATA_HOME:-$HOME/.local/share}"/gnupg
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}"/go
export PYENV_ROOT="${XDG_DATA_HOME:-$HOME/.local/share}"/pyenv
export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"/rustup

# Python
export PYTHONPYCACHEPREFIX="${XDG_CACHE_HOME:-$HOME/.cache}"/python
export PYTHONUSERBASE="${XDG_DATA_HOME:-$HOME/.local/share}"/python
export PYTHON_HISTORY="${XDG_STATE_HOME:-$HOME/.local/state}"/python/history

# fzf
export FZF_DEFAULT_COMMAND="fd --color never --exclude .git --follow --hidden --type file"
export FZF_DEFAULT_OPTS="--reverse --color bg+:-1"

# nnn
export NNN_BMS="D:~/Downloads;c:~/git/dot;d:~/Documents;g:~/git;t:~/git/tex;w:~/workspace;"
export NNN_FCOLORS="000004300000000000000000"
export NNN_FIFO="/tmp/nnn.fifo"
export NNN_OPENER="$HOME"/.local/bin/nuke
export NNN_OPTS="AEHder"
export NNN_TRASH=1

# Utilities
export EDITOR="nvim"
export PAGER="less"

# Miscellaneous settings
export ESCDELAY=0
export LC_ALL=en_US.UTF-8
export LESSHISTFILE="-"
export MANPAGER="nvim +Man!"

# Add to `$PATH`
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH"
export PATH="${XDG_DATA_HOME:-$HOME/.local/share}/cargo/bin:$PATH"
export PATH="/opt/homebrew/opt/trash-cli/bin:$PATH"
