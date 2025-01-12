# `dot`

Configuration files and setup instructions for Linux & macOS meta distribution.

All programs are chosen with simplicity in mind. Cross-platform programs that follow the
[UNIX philosophy][unix] are preferred. The setup is compliant with the
[XDG Base Directory Specification][xdg].

The setup is intended for (Arch) Linux and macOS.

<p float="left">
  <img src="https://wiki.installgentoo.com/images/f/f9/Arch-linux-logo.png" width="150px" height="150px"/>
  <img src="https://upload.wikimedia.org/wikipedia/commons/9/95/Homebrew_logo.svg" width="150px" height="150px" />
</p>

**NOTE**: For (Arch) Linux, switch to the `linux` branch.

## Setup

> [!IMPORTANT]
> Copy over the contents and create directories:
>
> ```console
> \cp -R .config .local .zshenv "$HOME"
> \mkdir -p "$HOME/git" "$HOME/workspace" "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
> ```
>
> Install packages:
>
> ```console
> xargs brew install < brew.txt
> ```

> [!TIP]
> Change shell to Zsh
>
> ```console
> chsh -s /usr/bin/zsh
> ```

## License

[MIT License][license]

[unix]: https://en.wikipedia.org/wiki/Unix_philosophy
[xdg]: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
[license]: LICENSE
