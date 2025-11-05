# Author: David Oniani <onianidavid@gmail.com>
# Description: zsh configuration file
# License: MIT

# Eval and Sourcing {{{

typeset -A plugins=(
    ["zsh-defer"]="https://github.com/romkatv/zsh-defer.git"
    ["zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
    ["zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions.git"
)

plugin_dir="${XDG_DATA_HOME:-$HOME/.local/share}"/zsh/plugin
mkdir -p "$plugin_dir"
for name url in ${(kv)plugins}; do
    [ ! -d "$plugin_dir/$name" ] && git clone --depth=1 "$url" "$plugin_dir/$name"
    fpath+="$plugin_dir/$name"
done

source "$plugin_dir"/zsh-defer/zsh-defer.plugin.zsh
zsh-defer source "$plugin_dir"/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
zsh-defer source "$plugin_dir"/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

zsh-defer eval "$(/opt/homebrew/bin/brew shellenv)"
zsh-defer eval "$(/opt/homebrew/bin/mise activate zsh)"

# }}}

# Prompt {{{

autoload -Uz add-zsh-hook vcs_info
add-zsh-hook precmd vcs_info
zstyle ':vcs_info:git:*' formats '(%b)'

setopt PROMPT_SUBST
PROMPT='%F{green}%n@core%f%F{red}:%f%F{blue}%1~%f %F{yellow}${vcs_info_msg_0_}%f %F{magenta}%#%f '

# }}}

# Z Shell Settings {{{

# Colors
autoload -Uz colors && colors

# Completion
cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
zcdump="$cache_dir/zcompdump_$ZSH_VERSION"
zcdumpzwc="$zcdump.zwc"
mkdir -p "$cache_dir"

zmodload -i zsh/complist
autoload -Uz compinit
if [[ ! -s $zcdump || $zcdump -nt $zcdumpzwc ]]; then
    compinit -d "$zcdump"
    zcompile "$zcdump"
else
    compinit -C -d "$zcdump"
fi

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
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# Misc
setopt AUTOCD
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP

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
alias img="viu"
alias j2py="jupyter nbconvert --to script"
alias l="gls -Av --color=auto --group-directories-first"
alias ll="gls -Ahlv --color=auto --group-directories-first"
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
function n() {
    # Block nesting of nnn in subshells
    [ "${NNNLVL:-0}" -eq 0 ] || {
        echo "nnn is already running"
        return
    }

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #      NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The command builtin allows one to alias nnn to n, if desired, without
    # making an infinitely recursive alias
    command nnn "$@"

    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f -- "$NNN_TMPFILE" > /dev/null
    }
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

bindkey -s "^f" "n\n"
bindkey -s "^p" "find_file_fuzzy\n"
bindkey -s "^r" "newsboat --quiet\n"
bindkey -s "^t" "find_session_fuzzy\n"
bindkey -s "^z" "fg\n"

# }}}
