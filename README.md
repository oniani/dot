# `dot`

<p align="center"><img src=".local/share/applications/kitty.png" alt="Logo" width="180" /></p>

Configuration files and automation wizard for \*nix meta distribution.

## Setup

All programs are chosen with simplicity in mind. Cross-platform programs that follow the UNIX
philosophy are preferred. The setup is compliant with the [XDG Base Directory Specification][xdg].

Core Tools and Utilities:

- Browser: [Brave][brave]
- Editor: [Neovim][neovim]
- File Manager: [nnn][nnn]
- Image viewer: [qimgv][qimgv]
- Media Player: [mpv][mpv]
- PDF Viewer: [zathura][zathura]
- Screenshot Utility: [Flameshot][flameshot]
- Shell: [zsh][zsh]
- Statusbar: [i3status-rust][i3statusrust]
- Terminal: [kitty][kitty]
- Window Manager: [i3-gaps][i3gaps]

Other Tools and Utilities:

- Diagram Maker: [drawio][drawio]
- IDE: [VS Code][vscode] (JupyterLab replacement, [Neovim][neovim] for everything else)

Automation:

```console
$ ./setup --help
```

## `$HOME` Directory Structure

```console
.cache     # User cache(s)
.config    # User config(s)
.local     # User data and programs(s)
aud        # Audio(s)
bld        # Build(s)
dls        # Download(s)
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
[i3statusrust]: https://github.com/greshake/i3status-rust
[kitty]: https://github.com/kovidgoyal/kitty
[i3gaps]: https://github.com/Airblader/i3
[drawio]: https://github.com/jgraph/drawio-desktop
[vscode]: https://github.com/microsoft/vscode
