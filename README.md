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

## Setup

Copy over the contents and create directories:

> [!IMPORTANT]
>
> ```console
> cp -R .config .local "$HOME"
> mkdir -p "$HOME/git" "$HOME/workspace" "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
> ```
>
> Install packages on Arch Linux
>
> ```console
> # Arch Official Repositories
> sudo pacman -S --noconfirm - < pkg_arch.txt
>
> # Arch User Repository
> sudo pacman -S --needed base-devel
> git clone https://aur.archlinux.org/paru.git && cd paru && makepkg -si && cd .. && rm -rf paru
> paru -S --noconfirm - < pkg_arch_aur.txt
> ```
>
> Install packages on macOS
>
> ```console
> xargs brew install < pkg_macos.txt
> ```

> [!TIP]
> It is possible to set a default location for `.zshenv`.
>
> ```console
> sudo touch /etc/zsh/zshenv
> printf "export ZDOTDIR=%s/.config/zsh\n" "$HOME" | sudo tee /etc/zsh/zshenv
> ```

> [!TIP]
> One can disable asking for a password when using `sudo`:
>
> ```console
> sudo touch "/etc/sudoers.d/$USER"
> printf "%s ALL=(ALL:ALL) NOPASSWD: ALL\n" "$USER" | sudo tee "/etc/sudoers.d/$USER"
> ```

> [!TIP]
> Stop generating `.sudo_as_admin_successful`.
>
> ```console
> sudo touch /etc/sudoers.d/disable_admin_file_in_home
> printf "Defaults !admin_flag\n" | sudo tee /etc/sudoers.d/disable_admin_file_in_home
> ```

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
