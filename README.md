# `dots`

![Desktop](demo.png)

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

All of the templates and configuration files along with the programs are chosen
with the simplicity in mind, and in most cases, cross-platform tools and
applications are preferred. The repository attempts to only include minimal
software, following the UNIX philosophy. In other words, software that software
that runs fast and has a limited number of bugs (or no bugs at all).

`dots` was initially designed for **macOS** operating system, but virtually
everything works on most **Linux** distributions with a few exceptions
including `wp` script, **skhd** and the tiling window manager **Amethyst**.
**Homebrew** might not work on all Linux distributions, so one will have to use
some other, distribution-specific package manager such as `apt`, `pacman`, etc.
Some applications and tools used for this setup have even more minimal
alternatives, yet the functionality of such tools is usually more limited and
therefore, there is a size/minimalism-functionality trade-off. The repo tries
to get the most without losing the performance.

For **macOS** users, there is an automated installation option that takes care
of the setup.

Bear in mind that this repository will always be a work-in-progress until that
**ONE** perfect setup is found which, quite frankly, will probably never
happen.

## Organization

The setup is compliant with the [XDG Base Directory
Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html).

## Setup

- Addressbook: [Abook](http://abook.sourceforge.net/)
- Colorscheme Generator: [pywal](https://github.com/dylanaraps/pywal)
- Default Colorscheme: [Gruvbox Dark Hard](https://github.com/morhetz/gruvbox)
- Document Viewer: [Preview](<https://en.wikipedia.org/wiki/Preview_(macOS)>) / [Zathura](https://github.com/zegervdv/homebrew-zathura)
- Editor: [Neovim](https://neovim.io/)
- Email: [neomutt](https://neomutt.org/) (with [isync](http://isync.sourceforge.net/) for mailbox synchronization and [msmtp](https://marlam.de/msmtp/) for sending emails)
- File Format Handler: [pandoc](https://pandoc.org/)
- File Manager: [Vifm](https://vifm.info/)
- Font: [Hack Regular Nerd Font Complete](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf)
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
- Wallpaper: [wallpaper47.jpg](https://github.com/oniani/wallpapers/blob/master/wallpapers/wallpaper47.jpg)
- Web Browser: [Firefox](https://www.mozilla.org/en-US/firefox/)
- Window Manager: [Amethyst](https://github.com/ianyh/Amethyst) / [bspwm](https://github.com/baskerville/bspwm)

Code Formatting

- CSS/HTML/JavaScript/Markdown: [Prettier](https://prettier.io/)
- Python: [Black](https://black.readthedocs.io/en/stable/)
- R: [styler](https://github.com/r-lib/styler)
- Rust: [rustfmt](https://github.com/rust-lang/rustfmt)

Code Linting

- Haskell: [hlint](http://hackage.haskell.org/package/hlint)
- JavaScript: [eslint](https://eslint.org/)
- Markdown: [mdl](https://github.com/DavidAnson/markdownlint)
- Python: [pylint](https://www.pylint.org/) and [mypy](http://mypy-lang.org/)
- R: [lintr](https://github.com/jimhester/lintr)
- Rust: [Clippy](https://rust-lang.github.io/rust-clippy/)
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

- [Base16 Vim](https://github.com/chriskempson/base16-vim/)
- [fzf.vim](https://github.com/junegunn/fzf.vim)
- [goyo.vim](https://github.com/junegunn/goyo.vim)
- [vim-commentary](https://github.com/tpope/vim-commentary)
- [vim-polyglot](https://github.com/sheerun/vim-polyglot)

#### Current Stats

Plugins arranged according to their startup time.

| TOP | Time (ms) | Plugin         |
| --- | --------- | -------------- |
| 1   | 10.064    | base16-vim     |
| 2   | 2.719     | vim-polyglot   |
| 3   | 1.029     | fzf.vim        |
| 4   | 0.898     | fzf            |
| 5   | 0.200     | vim-commentary |
| 6   | 0.031     | goyo.vim       |

This results in an average of 14.941 ms delay for the startup time.

The chart was generated using
[vim-plugins-profile](https://github.com/hyiltiz/vim-plugins-profile).

#### Key Mappings

| Key Mapping      | Functionality                              | Mnemonic |
| ---------------- | ------------------------------------------ | -------- |
| `<Space>`        | Space is the Leader key                    |          |
| `<Space><Space>` | Toggle between buffers                     |          |
| `<Leader>b`      | Select a buffer                            | Buffer   |
| `<Leader>c`      | Generic compiler and runner                | Compile  |
| `<Leader>f`      | Use fzf for file searching                 | Find     |
| `<Leader>l`      | Search for a line with a pattern in a file | Line     |
| `<Leader>o`      | Open the generated PDF file                | Open     |
| `<Leader>p`      | Use fzf for picking a colorscheme          | Palette  |
| `<Leader>r`      | Use fzf and rg for the string search       | Rg       |
| `<Leader>s`      | Toggle spell checking                      | Spell    |
| `<Leader>t`      | Open to-do list in the vertical split      | To-do    |
| `<Leader>w`      | Toggle line-wrapping                       | Wrap     |
| `<Leader>z`      | Toggle Goyo                                | Zen      |
| `<CR>`           | Unset the last registered search pattern   |          |
| `C-h`            | Switch to the left window                  |          |
| `C-j`            | Switch to the bottom window                |          |
| `C-k`            | Switch to the top window                   |          |
| `C-l`            | Switch to the right window                 |          |

### Automated Installation

In order to start the installation wizard, execute the commands below:

```sh
git clone https://github.com/oniani/dots
cd dots
./setup all
```

Also, please make sure that the system runs the latest macOS operating system.

## License

[GNU General Public License v3.0](LICENSE)
