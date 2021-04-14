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
cp -R .config "$HOME"
cp -R .ghc "$HOME"
cp -R .local "$HOME"
cp .zshenv "$HOME"

# Install/update Z shell plugins
DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugin"
ORG="https://github.com/zsh-users"

rm -rf "$DIR/zsh-autosuggestions" "$DIR/zsh-syntax-highlighting"

git clone -q "$ORG/zsh-autosuggestions" "$DIR/zsh-autosuggestions"
git clone -q "$ORG/zsh-syntax-highlighting" "$DIR/zsh-syntax-highlighting"
