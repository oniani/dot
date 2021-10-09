# ===============================================
#     Makefile
#     by David Oniani <onianidavid@gmail.com>
#     License: MIT License
# ===============================================

DIR = $${XDG_DATA_HOME:-$(HOME)/.local/share}/zsh/plugin
ORG = https://github.com/zsh-users

default: cp

cp: .config .local .zshenv
	cp -R .config $(HOME)
	cp -R .local  $(HOME)
	cp    .zshenv $(HOME)

nnn:
	git clone https://github.com/jarun/nnn
	cd nnn && make O_NERD=1 && sudo make install
	rm -rf nnn

zsh:
	rm -rf $(DIR)/zsh-autosuggestions $(DIR)/zsh-syntax-highlighting
	git clone $(ORG)/zsh-autosuggestions $(DIR)/zsh-autosuggestions
	git clone $(ORG)/zsh-syntax-highlighting $(DIR)/zsh-syntax-highlighting
	curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

rust:
	curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh

.PHONY: cp nnn zsh
