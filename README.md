# `dots`

---

## Table of Contents

- [Philosophy](#philosophy)
- [Organization](#organization)
- [Setup](#setup)
- [Z Shell](#z-shell)
- [Neovim](#neovim)
- [Automated Installation](#automated-installation)
- [License](#license)

---

## Philosophy

<img src="demo.png" alt="Desktop" align="right" width="500px">

All programs are chosen with simplicity in mind. Cross-platform programs that
follow the UNIX philosophy are preferred.

`dots` was initially designed for **macOS** operating system, but virtually
everything works on most **Linux** distributions with a few exceptions
including `wp` script and the tiling window manager **Amethyst**. **Homebrew**
might not work on all Linux distributions, so one will have to use some other,
distribution-specific package manager such as `apt`, `pacman`, etc. Some
programs used for this setup have even more minimal alternatives, yet the
functionality of such tools is often more limited and therefore, there is a
functionality-minimalism trade-off. The repo tries to get the most without
compromising too much.

Bear in mind that this repository will always be a work-in-progress until that
**ONE** perfect setup is found which, quite frankly, will probably never
happen.

## Organization

The setup is compliant with the [XDG Base Directory
Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html).

## Setup

- Addressbook: [Abook](http://abook.sourceforge.net/)
- Colorscheme Generator: [pywal](https://github.com/dylanaraps/pywal)
- Default Colorscheme: [moonfly](https://github.com/bluz71/vim-moonfly-colors)
- Document Viewer: [Preview](https://support.apple.com/guide/preview/welcome/mac) / [Zathura](https://github.com/zegervdv/homebrew-zathura)
- Editor: [Neovim](https://neovim.io/)
- File Format Handler: [pandoc](https://pandoc.org/)
- File Manager: [nnn](https://github.com/jarun/nnn)
- Font: [Iosevka Term Nerd Font Complete Mono](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Iosevka)
- Fuzzy Finder: [fzf](https://github.com/junegunn/fzf)
- Image Viewer: [Preview](<https://en.wikipedia.org/wiki/Preview_(macOS)>) / [sxiv](https://github.com/muennich/sxiv)
- Music Player: [ncmpcpp](https://rybczak.net/ncmpcpp/) (with [mpd](https://www.musicpd.org/) as a backend)
- Package Manager: [Homebrew](https://brew.sh/)
- Password Manager: [Pass](https://www.passwordstore.org/)
- RSS Reader: [Newsboat](https://newsboat.org/)
- Shell: [Z Shell](http://zsh.sourceforge.net/)
- Terminal Emulator: [kitty](https://sw.kovidgoyal.net/kitty/)
- Version Control: [Git](https://git-scm.com/downloads)
- Video Player: [mpv](https://mpv.io/)
- Web Browser: [Brave](https://brave.com/)
- Window Manager: [Amethyst](https://github.com/ianyh/Amethyst) / [bspwm](https://github.com/baskerville/bspwm)

Code Formatting

- CSS/HTML/JavaScript/Markdown: [Prettier](https://prettier.io/)
- Python: [Black](https://black.readthedocs.io/en/stable/)

Code Linting

- Haskell: [hlint](http://hackage.haskell.org/package/hlint)
- JavaScript: [eslint](https://eslint.org/)
- Markdown: [mdl](https://github.com/DavidAnson/markdownlint)
- Python: [pyright](https://github.com/Microsoft/pyright)
- Shell: [ShellCheck](https://www.shellcheck.net/)

### Z Shell

#### Plugins

No plugin manager is used. Plugins are sourced at the end of `.zshrc`.

- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

### Neovim

#### Plugins

Plugins are installed and managed using a minimalist plugin manager
[vim-plug](https://github.com/junegunn/vim-plug).

- [coc.nvim](https://github.com/neoclide/coc.nvim)
- [dracula](https://github.com/dracula/vim)
- [fzf.vim](https://github.com/junegunn/fzf.vim)
- [fzf](https://github.com/junegunn/fzf)
- [lightline.vim](https://github.com/itchyny/lightline.vim)
- [nvim-tree.lua](kyazdani42/nvim-tree.lua)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [playground](https://github.com/nvim-treesitter/playground)
- [vim-commentary](https://github.com/tpope/vim-commentary)
- [vim-fugitive](https://github.com/tpope/vim-fugitive)

#### Current Stats

Plugins arranged according to their startup time.

| TOP | Time (ms) | Plugin            |
| --- | --------- | ----------------- |
| 1   | 12.583    | vim               |
| 2   | 9.108     | coc.nvim          |
| 3   | 1.763     | vim-fugitive      |
| 4   | 1.709     | nvim-treesitter   |
| 5   | 1.139     | fzf               |
| 6   | 1.103     | fzf.vim           |
| 7   | 0.213     | vim-commentary    |
| 8   | 0.118     | nvim-tree.lua     |
| 9   | 0.056     | nvim-web-devicons |

This results in approximately 27.792 ms delay on average for the startup time.

The chart was generated using
[vim-plugins-profile](https://github.com/hyiltiz/vim-plugins-profile).

#### Key Mappings

| Key Mapping        | Functionality                              | Mnemonic  |
| ------------------ | ------------------------------------------ | --------- |
| `<Space>`          | Space is the Leader key                    |           |
| `<Leader><Leader>` | Toggle between buffers                     |           |
| `<Leader>c`        | Generic compiler and runner                | Compile   |
| `<Leader>f`        | Use fzf for file searching                 | Find      |
| `<Leader>l`        | Search for a line with a pattern in a file | Line      |
| `<Leader>r`        | Use fzf and rg for the string search       | Rg        |
| `<Leader>s`        | Toggle spell checking                      | Spell     |
| `<Leader>w`        | Toggle line-wrapping                       | Wrap      |
| `C-n`              | Open nvim-tree window                      | nvim-tree |
| `C-h`              | Switch to the left window                  |           |
| `C-j`              | Switch to the bottom window                |           |
| `C-k`              | Switch to the top window                   |           |
| `C-l`              | Switch to the right window                 |           |

### Automated Installation

```console
$ git clone https://github.com/oniani/dots
$ cd dots
$ ./setup.lua
$ brew bundle
$ exec zsh -l
```

Also, please make sure that the system runs the latest macOS operating system.
Note that the setup script is idempotent: it can safely be run multiple times.

## License

[MIT License](LICENSE)
