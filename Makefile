# Makefile
# by David Oniani <onianidavid@gmail.com>
# License: MIT License

DIR = $${XDG_DATA_HOME:-$(HOME)/.local/share}/zsh/plugin
ORG = https://github.com/zsh-users

default: help

all: cp nnn rust zsh

cp: .config .local .zshenv
	cp -R .config $(HOME)
	cp -R .local  $(HOME)
	cp    .zshenv $(HOME)

help:
	printf "OPTIONS:\n \
		all	Perform all actions listed below at once\n \
		cp	Copy configuration files\n \
		kitty	Install kitty terminal emulator\n \
		nnn	Install nnn file manager\n \
		rust	Install Rust programming language\n \
		zsh	Install Z Shell plugins\n"

nnn:
	git clone https://github.com/jarun/nnn
	cd nnn && make O_NERD=1 && sudo make install
	rm -rf nnn

rust:
	curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh

zsh:
	rm -rf $(DIR)/zsh-autosuggestions $(DIR)/zsh-syntax-highlighting
	git clone $(ORG)/zsh-autosuggestions $(DIR)/zsh-autosuggestions
	git clone $(ORG)/zsh-syntax-highlighting $(DIR)/zsh-syntax-highlighting

.SILENT: help
