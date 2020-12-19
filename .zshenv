#
# Author:   David Oniani
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

# Make directories reachable
export PATH="${XDG_CONFIG_HOME:-$HOME/.config}/cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Core utilities
export BROWSER="brave browser"
export EDITOR="nvim"
export IMAGE="preview"
export PAGER="less"
export READER="preview"
export TERMINAL="kitty"
export VIDEO="preview"

# nnn
export NNN_BMS="D:~/Downloads;c:~/git/dots;d:~/Documents;g:~/git;w:~/wip;"
export NNN_FCOLORS='0000E600000000E600000000'
export NNN_OPTS="EHderx"
export NNN_TRASH=1

# fzf
export FZF_DEFAULT_COMMAND="fd --hidden --type f"
export FZF_DEFAULT_OPTS="--reverse --height=50%"

# Move to ~/.config
export CARGO_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/cargo"
export GNUPGHOME="${XDG_CONFIG_HOME:-$HOME/.config}/gnupg"
export IPYTHONDIR="${XDG_CONFIG_HOME:-$HOME/.config}/ipython"
export JUPYTER_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/jupyter"
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/notmuch/config"
export PASSWORD_STORE_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/pass"
export RUSTUP_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/rustup"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

# Move to ~/.cache
export MYPY_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/mypy"
export NPM_CONFIG_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/npm"

# Additional settings
export CLICOLOR=1
export LC_ALL=en_US.UTF-8
export LESSHISTFILE="-"
export MANPAGER="nvim +Man!"
