# `dot`

Configuration files and automation wizard for \*nix meta distribution.

## Setup

All programs are chosen with simplicity in mind. Cross-platform programs that follow the UNIX
philosophy are preferred. The setup is compliant with the [XDG Base Directory Specification][xdg].

Core Tools and Utilities:

| Type               | Program                       |
| ------------------ | ----------------------------- |
| Browser            | [Google Chrome][chrome]       |
| Editor             | [Neovim][neovim]              |
| File Manager       | [nnn][nnn]                    |
| Image Viewer       | [nsxiv][nsxiv]                |
| Media Player       | [mpv][mpv]                    |
| PDF Viewer         | [zathura][zathura]            |
| Screenshot Utility | [Flameshot][flameshot]        |
| Shell              | [zsh][zsh]                    |
| Statusbar          | [i3status-rust][i3statusrust] |
| Terminal           | [kitty][kitty]                |
| Window Manager     | [i3][i3]                      |

Other Tools and Utilities:

- Design Tool: [Inkscape][inkscape]
- Diagram Maker: [drawio][drawio]
- IDE: [VS Code][vscode] (JupyterLab replacement, [Neovim][neovim] for everything else)

Automation:

```console
$ ./auto
```

## `$HOME` Directory Structure

```console
.cache     # User cache
.config    # User configs
.local     # User data and programs
dl         # Downloads
doc        # Documents
git        # Git repos
pic        # Pictures
wip        # Work in Progress Files
```

## License

[MIT License][license]

[license]: LICENSE
[xdg]: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
[chrome]: https://github.com/googlechrome
[neovim]: https://github.com/neovim/neovim
[nnn]: https://github.com/jarun/nnn
[nsxiv]: https://github.com/nsxiv/nsxiv
[mpv]: https://github.com/mpv-player/mpv
[zathura]: https://en.wikipedia.org/wiki/Zathura_(document_viewer)
[flameshot]: https://github.com/flameshot-org/flameshot
[zsh]: https://github.com/zsh-users/zsh
[i3statusrust]: https://github.com/greshake/i3status-rust
[kitty]: https://github.com/kovidgoyal/kitty
[i3]: https://github.com/i3/i3
[inkscape]: https://gitlab.com/inkscape/inkscape
[drawio]: https://github.com/jgraph/drawio-desktop
[vscode]: https://github.com/microsoft/vscode
