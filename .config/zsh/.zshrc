# zsh configuration file
# by David Oniani <onianidavid@gmail.com>
# MIT License

# Eval and Sourcing {{{

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(mise activate zsh)"

typeset -A plugins=(
    ["zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions.git"
    ["zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
)

dir_cfg="${XDG_DATA_HOME:-$HOME/.local/share}"/zsh/plugin
for plugin in ${(k)plugins}; do
    [ ! -d "$dir_cfg/$plugin" ] && git clone --depth=1 "$plugins[$plugin]" "$dir_cfg/$plugin"
done

source "$dir_cfg"/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source "$dir_cfg"/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

# }}}

# Z Shell Settings {{{

# Prompt
PROMPT='%F{green}%n@core%F{red}:%F{blue}%1~%F{magenta} $%f '

# Colors
autoload -Uz colors && colors

# Completion
autoload -Uz compinit && compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump_$ZSH_VERSION"
zmodload zsh/complist
zstyle ":completion:*" accept-exact-dirs true
zstyle ":completion:*" insert-tab false
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
zstyle ":completion:*" list-dirs-first true
zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"
zstyle ":completion:*" menu select
setopt COMPLETE_ALIASES
setopt GLOBDOTS

# History
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
HISTSIZE=10000
SAVEHIST=10000
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt INC_APPEND_HISTORY

# Misc
setopt AUTOCD
setopt INTERACTIVE_COMMENTS

# }}}

# Z Shell Vi Mode and Widgets {{{

# Enable Vi mode on the commmand line
bindkey -v

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

# Add missing Vim hotkeys
# Confer http://zshwiki.org/home/zle/vi-mode
bindkey -a u undo
bindkey -a "^r" redo
bindkey "^?" backward-delete-char

# History search in Vi mode
# Adapted from the following link
# http://zshwiki.org./home/zle/bindkeys#why_isn_t_control-r_working_anymore
# CTRL + h to search history
bindkey -M vicmd "^h" history-incremental-search-backward
bindkey -M viins "^h" history-incremental-search-backward

# Use Vi keys in tab complete menu
bindkey -M menuselect "h" vi-backward-char
bindkey -M menuselect "j" vi-down-line-or-history
bindkey -M menuselect "k" vi-up-line-or-history
bindkey -M menuselect "l" vi-forward-char

# Edit command in Vim
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd "^e" edit-command-line
bindkey -M viins "^e" edit-command-line

# Change cursor shape based on the Vi mode
zle-keymap-select() {
    case $KEYMAP in
        # Normal mode
        vicmd) echo -ne "\e[2 q";;

        # Insert mode
        viins|main) echo -ne "\e[6 q";;
    esac
}

zle-line-init() {
    # Initiate `vi insert` as keymap
    # NOTE: Can be removed if `bindkey -V` has been set elsewhere
    zle -K viins
    echo -ne "\e[6 q"
}

zle -N zle-keymap-select
zle -N zle-line-init

# }}}

# Aliases {{{

# Core commands
alias :q="exit"
alias cal="cal -m -3"
alias diff="diff --color=auto"
alias doc2pdf="libreoffice --headless --invisible --norestore --convert-to pdf"
alias grep="grep --color=auto"
alias icat="kitty +kitten icat"
alias j2py="jupyter nbconvert --to script"
alias l="gls -Av --color=auto --group-directories-first"
alias ll="gls -Ahlv --color=auto --group-directories-first"
alias s="bat --plain"
alias ssh="kitty +kitten ssh"
alias wget="wget --show-progress"
alias x="latexmk -interaction=nonstopmode -pdf -outdir=target"
alias xa="latexmk -interaction=nonstopmode -pdf -pvc -outdir=target"

# Interactive
alias e="nvim"
alias g="nvim +Git +only"
alias gl="nvim '+Git log --stat' +only"
alias j="python -m jupyterlab"
alias t="tmux"

# Safer commands
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

# }}}

# Functions {{{

# Change directory on quit
function nnn_autocd() {
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        printf "nnn is already running\n"
        return
    fi

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, either remove the "export" as in:
    #    NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    #    (or, to a custom path: NNN_TMPFILE=/tmp/.lastd)
    # or, export NNN_TMPFILE after nnn invocation
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn -T v "$@"

    if [ -f "$NNN_TMPFILE" ]; then
        . "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

# Fuzzy find files
function find_file_fuzzy() {
    fzf --preview "bat --color=always --theme=base16-256 {}" \
        --prompt "File: " |
        xargs -r -I {} "$EDITOR" {}
}

# Fuzzy find tmux session
function find_session_fuzzy() {
    selected=$(tmux list-sessions | fzf | cut -d':' -f1)
    ([ -z "$selected" ] && exit 0) || tmux attach -t "$selected"
}

# Print the color map
function colormap() {
    for i in {0..255}; do
        print -Pn "%${i}F${(l:3::0:)i}%f " ${${(M)$((i%8)):#7}:+$'\n'};
    done
}

# Print the current palette
function palette() {
    local -a colors
    for i in {000..16}; do
        colors+=("%F{$i}hello: $i%f")
    done
    print -cP $colors
}

# }}}

# Key Bindings {{{

bindkey -s "^f" "nnn_autocd\n"
bindkey -s "^p" "find_file_fuzzy\n"
bindkey -s "^r" "newsboat --quiet\n"
bindkey -s "^t" "find_session_fuzzy\n"
bindkey -s "^z" "fg\n"

# }}}
