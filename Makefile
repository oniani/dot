# Makefile
# by David Oniani <onianidavid@gmail.com>
# License: MIT License

DIR = $${XDG_DATA_HOME:-$$HOME/.local/share}/zsh/plugin

default: help

all: cp nnn rust zsh

cp: .config .local .zshenv
	cp    -R .config $$HOME
	cp 	  -R .local  $$HOME
	cp       .zshenv $$HOME
	mkdir -p $$HOME/.local/{bin,share}
	mkdir -p $${XDG_CACHE_HOME:-$$HOME/.cache}

help:
	printf "OPTIONS:\n \
		all	Perform all actions listed below at once\n \
		cp	Copy configuration files\n \
		kitty	Install kitty terminal emulator\n \
		nnn	Install mpv media player\n \
		nnn	Install nnn file manager\n \
		rust	Install Rust programming language\n \
		zsh	Install Z Shell plugins\n"

mpv:
	git clone https://github.com/mpv-player/mpv
	cd mpv && ./bootstrap.py && ./waf configure && ./waf && ./waf install
	rm -rf mpv

nnn:
	git clone https://github.com/jarun/nnn
	cd nnn && make O_NERD=1 && sudo make install
	rm -rf nnn

rust:
	curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh

zsh:
	rm -rf $(DIR)/zsh-autosuggestions $(DIR)/zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-autosuggestions $(DIR)/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting $(DIR)/zsh-syntax-highlighting

.SILENT: help
