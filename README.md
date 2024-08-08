# `dot`

Configuration files and automation wizard for Arch Linux meta distribution

## Setup

All programs are chosen with simplicity in mind. Cross-platform programs that follow the [UNIX
philosophy][unix] are preferred. The setup is compliant with the [XDG Base Directory
Specification][xdg].

Core Tools and Utilities:

| Type           | Program                         |
| -------------- | ------------------------------- |
| Browser        | [Firefox][firefox]              |
| Editor         | [Neovim][neovim]                |
| File Manager   | [nnn][nnn]                      |
| Font           | [JetBrains Mono][jetbrainsmono] |
| Image Viewer   | [nsxiv][nsxiv]                  |
| Media Player   | [mpv][mpv]                      |
| PDF Viewer     | [zathura][zathura]              |
| Shell          | [zsh][zsh]                      |
| Terminal       | [kitty][kitty]                  |
| Window Manager | [Hyprland][hyprland]            |

Other Tools and Utilities:

- Design Tool: [Inkscape][inkscape]
- Diagram Maker: [drawio][drawio]
- Notebooks: [JupyterLab][jupyterlab]

Manually patched Comic Mono font is available [here][font].

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
vid        # Videos
wip        # Work in Progress Files
```

## License

[MIT License][license]

[unix]: https://en.wikipedia.org/wiki/Unix_philosophy
[xdg]: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
[firefox]: https://www.mozilla.org/en-US/firefox/new/
[neovim]: https://github.com/neovim/neovim
[nnn]: https://github.com/jarun/nnn
[jetbrainsmono]: https://github.com/JetBrains/JetBrainsMono
[nerdfontspatcher]: https://github.com/ryanoasis/nerd-fonts#font-patcher
[ligaturizer]: https://github.com/ToxicFrog/Ligaturizer
[nsxiv]: https://github.com/nsxiv/nsxiv
[mpv]: https://github.com/mpv-player/mpv
[zathura]: https://en.wikipedia.org/wiki/Zathura_(document_viewer)
[zsh]: https://github.com/zsh-users/zsh
[kitty]: https://github.com/kovidgoyal/kitty
[hyprland]: https://github.com/hyprwm/Hyprland
[inkscape]: https://gitlab.com/inkscape/inkscape
[drawio]: https://github.com/jgraph/drawio-desktop
[jupyterlab]: https://jupyter.org
[font]: https://github.com/oniani/dot/tree/main/.local/share/fonts/ttf
[license]: LICENSE
