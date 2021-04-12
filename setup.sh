#!/usr/bin/env sh
#
# Author: David Oniani
#           _                    _
#  ___  ___| |_ _   _ _ __   ___| |__
# / __|/ _ \ __| | | | '_ \ / __| '_ \
# \__ \  __/ |_| |_| | |_) |\__ \ | | |
# |___/\___|\__|\__,_| .__(_)___/_| |_|
#                    |_|
#

# Copy configs
for cfg in ".config" ".local" ".ghc" ".zshenv"; do
    cp -Rf "$cfg" "$HOME"
done

# Install Z shell plugins
PLUGIN_PATH="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugin"

ZSH_AUTOSUGGEST_DIR="$PLUGIN_PATH/zsh-autosuggestions"
ZSH_AUTOSUGGEST_REPOSITORY="https://github.com/zsh-users/zsh-autosuggestions"

ZSH_SYNTAX_DIR="$PLUGIN_PATH/zsh-syntax-highlighting"
ZSH_SYNTAX_REPOSITORY="https://github.com/zsh-users/zsh-syntax-highlighting"

# Remove plugins
rm -rf $ZSH_AUTOSUGGEST_DIR
rm -rf $ZSH_SYNTAX_DIR

# Quietly clone Git repositories
git clone --quiet $ZSH_AUTOSUGGEST_REPOSITORY $ZSH_AUTOSUGGEST_DIR
git clone --quiet $ZSH_SYNTAX_REPOSITORY $ZSH_SYNTAX_DIR
