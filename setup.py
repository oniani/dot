#!/usr/bin/env python3
import argparse
import json
import os
import platform
import subprocess

# Operating system
OS: str = platform.system()

if OS in {"Darwin", "Linux"}:
    PACKAGE_MANAGER = "brew"
    INSTALL_CMD = "install"
    UNINSTALL_CMD = "uninstall"

elif OS == "Windows":
    raise NotImplementedError("Not sure what to use, yet...")

# Environment variables
HOME: str = os.environ["HOME"]

EDITOR: str = "nvim"
if os.environ.get("EDITOR"):
    EDITOR = os.environ["EDITOR"]

CONFIG: str = f"{HOME}/.config"
if os.environ.get("XDG_CONFIG_HOME"):
    CONFIG = os.environ["XDG_CONFIG_HOME"]

# Configuration files
CFG_DIRS: list[str] = [".config", ".local", ".ghc"]
CFG_FILES: list[str] = [".zshenv"]

# Git
ZSH_AUTOSUGGEST: str = "https://github.com/zsh-users/zsh-autosuggestions"
ZSH_AUTOSUGGEST_DIR: str = f"{CONFIG}/zsh/plugin/zsh-autosuggestions"

ZSH_SYNTAX: str = "https://github.com/zsh-users/zsh-syntax-highlighting"
ZSH_SYNTAX_DIR: str = f"{CONFIG}/zsh/plugin/zsh-syntax-highlighting"


def git_clone(link: str, path: str) -> None:
    """Clone a repository into a new directory."""

    subprocess.run(["git", "clone", link, path, "--quiet"])


def rm_rf(path: str) -> None:
    """Recursively remove directory entries."""

    subprocess.run(["rm", "-rf", path])


class Programs:
    """A class for operating on programs."""

    def __init__(self) -> None:
        "Initialize variables." ""

        with open("programs.json") as programs:
            self._programs: list[dict[str, str]] = json.load(programs)

    @property
    def names(self) -> list[str]:
        """Get the names of programs."""

        return [program["name"] for program in self._programs]

    def __repr__(self) -> str:
        """Dataset representation."""

        val: int = max([len(name) for name in self.names])
        out: list[str] = []
        for program in self._programs:
            out.append(f"{program['name']:<{val}}: {program['description']}")
        out.sort()

        return "\n".join(out)


def main() -> None:
    """Process the command line arguments."""

    # Parse the command line arguments
    parser: argparse.ArgumentParser = argparse.ArgumentParser()

    # Specify the arguments
    parser.add_argument(
        "-i", "--install", metavar="program", help="install a program"
    )
    parser.add_argument(
        "-u", "--uninstall", metavar="program", help="uninstall a program"
    )
    parser.add_argument(
        "-a", "--install_all", action="store_true", help="install all programs"
    )
    parser.add_argument(
        "-c", "--config", action="store_true", help="copy configs"
    )
    parser.add_argument(
        "-z", "--zsh", action="store_true", help="install Z shell plugins"
    )
    parser.add_argument(
        "-l", "--list", action="store_true", help="list all programs"
    )

    # Parse the arguments
    args: argparse.Namespace = parser.parse_args()

    # Get the data
    programs: Programs = Programs()

    # Copy configs
    if args.config:
        for item in CFG_DIRS:
            subprocess.run(["cp", "-Rf", item, HOME])

        for item in CFG_FILES:
            subprocess.run(["cp", "-f", item, HOME])

    # Install a program
    elif args.install:
        subprocess.run([PACKAGE_MANAGER, INSTALL_CMD, args.install])

    # Remove a program
    elif args.uninstall:
        subprocess.run([PACKAGE_MANAGER, UNINSTALL_CMD, args.uninstall])

    # Install all programs
    elif args.install_all:
        for name in programs.names:
            subprocess.run([PACKAGE_MANAGER, INSTALL_CMD, name])

    # Install Z shell plugins
    elif args.zsh:
        rm_rf(ZSH_AUTOSUGGEST_DIR)
        rm_rf(ZSH_SYNTAX_DIR)

        git_clone(ZSH_AUTOSUGGEST, ZSH_AUTOSUGGEST_DIR)
        git_clone(ZSH_SYNTAX, ZSH_SYNTAX_DIR)

    # List all programs
    elif args.list:
        print(programs)


if __name__ == "__main__":
    main()
