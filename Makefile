#! ===============================================
#!     Makefile
#!     by David Oniani <onianidavid@gmail.com>
#!     License: MIT License
#! ===============================================
#! 

DIR = $${XDG_DATA_HOME:-$(HOME)/.local/share}/zsh/plugin
ORG = https://github.com/zsh-users

all: cp zsh

default: help

help: #! Show this message
	@sed -ne '/@sed/!s/#! //p' $(MAKEFILE_LIST)

cp:   #! Copy configs
	cp -R .config "$(HOME)"
	cp -R .local "$(HOME)"
	cp .zshenv "$(HOME)"

zsh:  #! Install/update Z shell plugins
	rm -rf $(DIR)/zsh-autosuggestions $(DIR)/zsh-syntax-highlighting
	git clone $(ORG)/zsh-autosuggestions $(DIR)/zsh-autosuggestions
	git clone $(ORG)/zsh-syntax-highlighting $(DIR)/zsh-syntax-highlighting

.SILENT: copy zsh
