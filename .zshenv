#
# Filename: .zshenv
# Author:   David Oniani
# Modified: April 20, 2020
#
#            _
#    _______| |__   ___ _ ____   __
#   |_  / __| '_ \ / _ \ '_ \ \ / /
#  _ / /\__ \ | | |  __/ | | \ V /
# (_)___|___/_| |_|\___|_| |_|\_/
#

# Make directories reachable
export PATH="$HOME/.config/cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Core utilities
export BROWSER="open -a /Applications/Firefox.app"
export EDITOR="nvim"
export FILEMANAGER="nnn"
export PAGER="less"
export PLAYER="mpv"
export READER="open -a /Applications/Preview.app"
export TERMINAL="kitty"

# fzf
export FZF_DEFAULT_COMMAND="fd --hidden --type f"
export FZF_DEFAULT_OPTS="--color=16 --height=50% --reverse"

# nnn
export NNN_BMS="D:~/Downloads;d:~/Documents;p:~/Pictures;w:~/work-in-progress;"
export NNN_PLUG='d:newdir;f:newfile;g:githubclone;p:pager'
export NNN_TRASH=1

# Move to ~/.config
export CARGO_HOME="$HOME/.config/cargo"
export IPYTHONDIR="$HOME/.config/ipython"
export JUPYTER_CONFIG_DIR="$HOME/.config/jupyter"
export RUSTUP_HOME="$HOME/.config/rustup"
export ZDOTDIR="$HOME/.config/zsh"

# Move to ~/.cache
export MYPY_CACHE_DIR="$HOME/.cache/mypy"
export NPM_CONFIG_CACHE="$HOME/.cache/npm"

# Additional settings
export CLICOLOR=1
export LANG=en_US.UTF-8
export LESSHISTFILE="-"
