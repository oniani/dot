# `dots`

Configurations files and the setup wizard for \*nix (UNIX-like) meta
distribution.

## Philosophy

<img src="demo.png" alt="Desktop" align="right" width="500px">

All programs are chosen with simplicity in mind. Cross-platform programs that
follow the UNIX philosophy are preferred.

## Organization

The setup is _mostly_ compliant with the [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html).

## Setup

- Colorscheme Generator: [pywal](https://github.com/dylanaraps/pywal)
- Default Colorscheme: [Dracula](https://github.com/dracula)
- Document/Image Viewer: [Preview](https://support.apple.com/guide/preview/welcome/mac)
- Editor: [Neovim](https://neovim.io/)
- File Manager: [nnn](https://github.com/jarun/nnn)
- Font: [Iosevka Term Nerd Font Complete Mono](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Iosevka)
- Fuzzy Finder: [fzf](https://github.com/junegunn/fzf)
- Music Player: [ncmpcpp](https://rybczak.net/ncmpcpp/) (with [mpd](https://www.musicpd.org/) as a backend)
- Package Manager: [Homebrew](https://brew.sh/)
- RSS Reader: [Newsboat](https://newsboat.org/)
- Shell: [Z Shell](http://zsh.sourceforge.net/)
- Terminal Emulator: [kitty](https://sw.kovidgoyal.net/kitty/)
- Video Player: [mpv](https://mpv.io/)
- Web Browser: [Brave](https://brave.com/)
- Window Manager: [Amethyst](https://github.com/ianyh/Amethyst)

### Z Shell

#### Plugins

No plugin manager is used. Plugins are sourced at the end of `.zshrc`.

- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

### Neovim

#### Plugins

Plugins are installed and managed using
[packer.nvim](https://github.com/wbthomason/packer.nvim).

Productivity:

- [neogit](https://github.com/TimUntersberger/neogit)
- [fzf](https://github.com/junegunn/fzf)
- [fzf.vim](https://github.com/junegunn/fzf.vim)
- [nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [vim-commentary](https://github.com/tpope/vim-commentary)

LSP:

- [nvim-compe](https://github.com/hrsh7th/nvim-compe)
- [nvim-lspinstall](https://github.com/kabouzeid/nvim-lspinstall)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)

Visuals:

- [tokyonight](https://github.com/folke/tokyonight.nvim)
- [dashboard-nvim](https://github.com/glepnir/dashboard-nvim)
- [lualine.nvim](https://github.com/hoob3rt/lualine.nvim)
- [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)

#### Key Mappings

| Key Mapping                 | Functionality                              | Mnemonic  |
| --------------------------- | ------------------------------------------ | --------- |
| <kbd><Space></kbd>          | Space is the Leader key                    |           |
| <kbd><Leader><Leader></kbd> | Toggle between buffers                     |           |
| <kbd><Leader>c</kbd>        | Generic compiler and runner                | Compile   |
| <kbd><Leader>f</kbd>        | Use fzf for file searching                 | Find      |
| <kbd><Leader>l</kbd>        | Search for a line with a pattern in a file | Line      |
| <kbd><Leader>r</kbd>        | Use fzf and rg for the string search       | Rg        |
| <kbd><Leader>s</kbd>        | Toggle spell checking                      | Spell     |
| <kbd><Leader>t</kbd>        | Toggle Neoterm vertical split              | Toggle    |
| <kbd><Leader>w</kbd>        | Toggle line-wrapping                       | Wrap      |
| <kbd>C-n</kbd>              | Open nvim-tree window                      | nvim-tree |
| <kbd>C-h</kbd>              | Switch to the left window                  |           |
| <kbd>C-j</kbd>              | Switch to the bottom window                |           |
| <kbd>C-k</kbd>              | Switch to the top window                   |           |
| <kbd>C-l</kbd>              | Switch to the right window                 |           |

### Automated Installation

```console
$ git clone https://github.com/oniani/dots
$ cd dots
$ ./setup.sh
$ brew bundle
$ exec zsh -l
```

Also, please make sure that the system runs the latest macOS operating system.
Note that the setup script is idempotent: it can be safely run multiple times.

## License

[MIT License](LICENSE)
