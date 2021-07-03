# `dots`

<p align="center"><img src="kitty.png" alt="Logo" width="225" /></p>

## Organization and Setup

All programs are chosen with simplicity in mind. Cross-platform programs that
follow the UNIX philosophy are preferred. The setup is compliant with the
[XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html).

Setup:

- Browser: [Brave](https://github.com/brave/brave-browser)
- Editor: [Neovim](https://github.com/neovim/neovim/)
- File Manager: [nnn](https://github.com/jarun/nnn)
- Media Player: [mpv](https://mpv.io/)
- Music Player: [ncmpcpp](https://rybczak.net/ncmpcpp/) (with [mpd](https://www.musicpd.org/) as a backend)
- RSS Reader: [Newsboat](https://newsboat.org/)
- Shell: [zsh](https://github.com/zsh-users/zsh)
- Terminal: [kitty](https://github.com/kovidgoyal/kitty/)

## Automated Installation

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
