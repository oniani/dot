#
# Filename: .zshrc
# Author:   David Oniani
# Modified: May 15, 2020
#
#            _
#    _______| |__  _ __ ___
#   |_  / __| '_ \| '__/ __|
#  _ / /\__ \ | | | | | (__
# (_)___|___/_| |_|_|  \___|
#

# Functions {{{

# Print the color map
function colormap() {
  for i in {0..255}; do
    print -Pn "%${i}F${(l:3::0:)i}%f " ${${(M)$((i%8)):#7}:+$'\n'};
  done
}

# Configure cd on quit for nnn
function nnn_autocd() {
  # Block nesting of nnn in subshells
  if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
    printf "nnn is already running\n"
    return
  fi

  export NNN_TMPFILE="$HOME/.config/nnn/.lastd"

  nnn "$@"

  if [ -f "$NNN_TMPFILE" ]; then
    . "$NNN_TMPFILE"
    rm -f "$NNN_TMPFILE" > /dev/null
  fi
}

# }}}

# Aliases {{{

# Core commands
alias :q="exit"
alias grep="grep --color=auto"
alias icat="kitty +kitten icat"
alias l="ls -Ahu"
alias ll="ls -Ahlu"
alias mkd="mkdir -p"

# Interactive
alias e='$EDITOR'
alias f='nnn_autocd'
alias m='$MAIL'
alias mp='$MUSIC --quiet'
alias rss='$RSS --quiet'

# Code formatting
alias black="black --line-length=79"
alias brittany="brittany --write-mode inplace --indent 4"

# Fancy
alias clock="tty-clock -c -s -t"

# }}}

# Z Shell Settings {{{

# Set the prompt
PROMPT="%F{03}%c %F{39}$%F{reset_color} "

# Load and enable colors
autoload -Uz colors && colors

# Load and enable completion
autoload -Uz compinit && compinit -d "$HOME/.cache/zsh/zcompdump_$ZSH_VERSION"

# Completion for kitty
kitty + complete setup zsh | source /dev/stdin

# Completion settings
zstyle ":completion:*" accept-exact-dirs true            # No parent completion
zstyle ":completion:*" insert-tab false                  # Do not insert a TAB
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"  # Colored menu
zstyle ":completion:*" list-dirs-first true              # Separate dir & file
zstyle ":completion:*" menu select                       # Completion menu

# Case/hyphen-insensitive autocompletion (à la Oh My Zsh)
zstyle ":completion:*" matcher-list "m:{a-zA-Z-_}={A-Za-z_-}" "r:|=*" "l:|=* r:|=*"
setopt COMPLETE_ALIASES  # Complete aliases
setopt GLOBDOTS          # Complete dotfiles

# History settings
HISTFILE="$HOME/.cache/zsh/zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt EXTENDED_HISTORY        # Add timestamps
setopt HIST_EXPIRE_DUPS_FIRST  # Remove duplicates first if over HISTSIZE
setopt INC_APPEND_HISTORY      # Save commands in the order of execution

# }}}

# Z Shell Vi Mode and Widgets {{{

# Enable Vi mode on the commmand line
bindkey -v

# Add missing Vim hotkeys
# Confer http://zshwiki.org/home/zle/vi-mode
bindkey -a u undo                  # u for undo
bindkey -a "^r" redo               # CTRL + r to redo
bindkey "^?" backward-delete-char  # Backspace

# History search in Vi mode
# Adapted from the following link
# http://zshwiki.org./home/zle/bindkeys#why_isn_t_control-r_working_anymore
# CTRL + h to search history
bindkey -M vicmd "^h" history-incremental-search-backward
bindkey -M viins "^h" history-incremental-search-backward

# No delay entering normal mode
# Confer https://coderwall.com/p/h63etq
# Confer https://github.com/pda/dotzsh/blob/master/keyboard.zsh#L10
#
# The time the shell waits, in hundredths of seconds, for another key
# to be pressed when reading bound multi-character sequences.
#
# Set to shortest possible delay is 1/100 second (10ms).
# This allows escape sequences like cursor/arrow keys to work,
# while eliminating the delay exiting Vi insert mode.
KEYTIMEOUT=1

# Use Vi keys in tab complete menu
zmodload zsh/complist
bindkey -M menuselect "h" vi-backward-char
bindkey -M menuselect "k" vi-up-line-or-history
bindkey -M menuselect "l" vi-forward-char
bindkey -M menuselect "j" vi-down-line-or-history

# Edit command in Vim
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd "^e" edit-command-line
bindkey -M viins "^e" edit-command-line

# Change cursor shape based on the Vi mode
zle-keymap-select() {
  # Normal mode
  if [ $KEYMAP = vicmd ] || [ $1 = 'block' ]; then
    echo -ne '\e[1 q'

  # Insert mode
  elif [ $KEYMAP = main ] || [ $KEYMAP = viins ] || [ $KEYMAP = '' ] ||
       [ $1 = 'beam' ]; then
    echo -ne '\e[5 q'
  fi
}

zle-line-init() {
    # Initiate `vi insert` as keymap
    # NOTE: Can be removed if `bindkey -V` has been set elsewhere
    zle -K viins
    echo -ne '\e[5 q'
}

zle -N zle-keymap-select
zle -N zle-line-init

# }}}

# Key Bindings {{{

# Launch the file manager
bindkey -s "^f" "f\n"

# ipython deserves its own key binding
bindkey -s "^p" "ipython\n"

# }}}

# Sourcing {{{

# Source Fish-like autocompletions for activation
source "$HOME/.config/zsh/plugin/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Source syntax highlighting for activation
source "$HOME/.config/zsh/plugin/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# }}}
