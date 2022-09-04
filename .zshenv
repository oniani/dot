#
# Author: David Oniani
#
#            _
#    _______| |__   ___ _ ____   __
#   |_  / __| '_ \ / _ \ '_ \ \ / /
#  _ / /\__ \ | | |  __/ | | \ V /
# (_)___|___/_| |_|\___|_| |_|\_/
#

# XDG base directory specification
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

# Move to ~/.cache
export CUDA_CACHE_PATH="${XDG_CACHE_HOME:-$HOME/.cache}/nv"
export MYPY_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/mypy"
export NPM_CONFIG_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/npm"

# Move to ~/.config
export GNUPGHOME="${XDG_CONFIG_HOME:-$HOME/.config}/gnupg"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/zsh/inputrc"
export IPYTHONDIR="${XDG_CONFIG_HOME:-$HOME/.config}/ipython"
export JUPYTER_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/jupyter"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

# Move to ~/.local/share
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go/packages"
export GOROOT="${XDG_DATA_HOME:-$HOME/.local/share}/go/go"
export PYENV_ROOT="${XDG_DATA_HOME:-$HOME/.local/share}/pyenv"
export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/rustup"

# Make directories reachable
export PATH="$HOME/.local/bin:$PATH"
export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"
export PATH="$HOME/bld/vscode:$PATH"
export PATH="$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH"
export PATH="${XDG_DATA_HOME:-$HOME/.local/share}/cargo/bin:$PATH"
export PATH="${XDG_DATA_HOME:-$HOME/.local/share}/go/bin:$PATH"

# nnn
export NNN_BMS="D:~/dls;b:~/bld;c:~/git/dot;d:~/doc;g:~/git;p:~/pic;v:~/vid;w:~/wip;"
export NNN_FCOLORS="000004000700000700000000"
export NNN_OPTS="EHderx"
export NNN_TRASH=1

# fzf
export FZF_DEFAULT_COMMAND="fd --hidden --type f"
export FZF_DEFAULT_OPTS="--reverse"

# bat
export BAT_STYLE="numbers"
export BAT_THEME="gruvbox-dark"

# Utilities
export EDITOR="nvim"
export PAGER="less"
export TERMINAL="kitty"

# Miscellaneous settings
export LC_ALL=en_US.UTF-8
export LESSHISTFILE="-"
export MANPAGER="nvim +Man!"
