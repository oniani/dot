# `dot`

<p align="center"><img src=".local/share/applications/kitty.png" alt="Logo" width="180" /></p>

## Setup

All programs are chosen with simplicity in mind. Cross-platform programs that follow the UNIX
philosophy are preferred. The setup is compliant with the [XDG Base Directory Specification][xdg].

Tools:

- Browser: [Brave][brave]
- Editor: [Neovim][neovim]
- File Manager: [nnn][nnn]
- Image viewer: [qimgv][qimgv]
- Media Player: [mpv][mpv]
- PDF Viewer: [zathura][zathura]
- RSS Reader: [Newsboat][newsboat]
- Screenshot Utility: [Flameshot][flameshot]
- Shell: [zsh][zsh]
- Terminal: [kitty][kitty]

Automation:

```console
$ ./setup --help
```

## `$HOME` Directory Structure

```console
.cache     # User cache(s)
.config    # User config(s)
.local     # User data and programs(s)
dls        # Download(s)
bld        # Build(s)
doc        # Document(s)
git        # Git repo(s)
pic        # Picture(s)
vid        # Video(s)
wip        # Work in Progress File(s)
.zshenv    # Exports Environment Variable(s)
```

## License

[MIT License](LICENSE)

[xdg]: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
[brave]: https://github.com/brave/brave-browser
[neovim]: https://github.com/neovim/neovim
[nnn]: https://github.com/jarun/nnn
[qimgv]: https://github.com/easymodo/qimgv
[mpv]: https://github.com/mpv-player/mpv
[zathura]: https://en.wikipedia.org/wiki/Zathura_(document_viewer)
[newsboat]: https://github.com/newsboat/newsboat
[flameshot]: https://github.com/flameshot-org/flameshot
[zsh]: https://github.com/zsh-users/zsh
[kitty]: https://github.com/kovidgoyal/kitty
