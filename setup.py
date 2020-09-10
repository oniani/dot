#!/usr/bin/env python3
import argparse
import csv
import os
import platform
import subprocess

from typing import Dict, List, Optional


# Operating system
OS: str = platform.system()

if OS == "Darwin":
    PACKAGE_MANAGER = "brew"
    INSTALL_CMD = "install"
    UNINSTALL_CMD = "uninstall"

elif OS == "Linux":
    PACKAGE_MANAGER = "sudo apt"
    INSTAL_CMDL = "install"
    UNINSTALL_CMD = "remove"

elif OS == "Windows":
    raise NotImplementedError("Not sure what to use, yet...")

# XDG base directory specification
CFG_DIR = os.environ.get("XDG_CONFIG_HOME")
if not CFG_DIR:
    CFG_DIR = CFG_DIR = os.environ["HOME"]

# Configuration files
CFG_DIRS: List[str] = [".config", ".local", ".ghc"]
CFG_FILES: List[str] = [".zshenv"]


class Dataset:
    """A class for operating on the dataset."""

    def __init__(self) -> None:
        "Initialize variables." ""

        self._data = list(csv.DictReader(open("programs.csv")))
        self._fields = ["tag", "name", "description"]

        # Make sure the fields match
        assert list(next(iter(self._data)).keys()) == self._fields

    @property
    def tags(self) -> List[str]:
        """Gets the names of the programs."""

        return [row_dict["tag"] for row_dict in self._data]

    @property
    def names(self) -> List[str]:
        """Gets the names of the programs."""

        return [row_dict["name"] for row_dict in self._data]

    @property
    def descriptions(self) -> List[str]:
        """Gets the names of the programs."""

        return [row_dict["description"] for row_dict in self._data]

    def get(self, field: str, name: str) -> Optional[Dict[str, str]]:
        """Get the particular item by name."""

        for row_dict in self._data:
            if row_dict[field] == name:
                return row_dict

        return None

    def __repr__(self) -> str:
        """Dataset representation."""

        val = max([len(name) for name in self.names])
        out = []
        for row_dict in self._data:
            out.append(f"{row_dict['name']:<{val}}: {row_dict['description']}")
        out.sort()

        return "\n".join(out)


def main() -> None:
    """Process the command line arguments."""

    # Parse the command line arguments
    parser = argparse.ArgumentParser()
    parser.add_argument("-i", "--install", help="install a package")
    parser.add_argument("-u", "--uninstall", help="uninstall a package")
    parser.add_argument("-c", "--config", action="store_true", help="configs")
    parser.add_argument("-v", "--vim", action="store_true", help="plugins")
    parser.add_argument("-z", "--zsh", action="store_true", help="plugins")
    parser.add_argument("-l", "--list", action="store_true", help="list")
    args = parser.parse_args()

    # Get the data
    data = Dataset()

    # Perform an action depending on command line flags
    if args.config:
        for item in CFG_DIRS:
            subprocess.run(["cp", "-Rf", item, os.environ["HOME"]])

        for item in CFG_FILES:
            subprocess.run(["cp", "-f", item, os.environ["HOME"]])

    # TODO: Handle GUI vs regular programs and consider incorporating tags
    #       It could potentially help simplify the setup script
    elif args.install:
        subprocess.run([PACKAGE_MANAGER, INSTALL_CMD, args.install])

    elif args.uninstall:
        subprocess.run([PACKAGE_MANAGER, UNINSTALL_CMD, args.uninstall])

    elif args.vim:
        subprocess.run(
            [
                os.environ["EDITOR"],
                "+PlugUpgrade",
                "+PlugClean!",
                "+PlugInstall",
                "+PlugUpdate",
                "+qa!",
            ]
        )

    elif args.zsh:
        subprocess.run(
            ["rm", "-rf", f"{CFG_DIR}/zsh/plugin/zsh-autosuggestions",]
        )

        subprocess.run(
            ["rm", "-rf", f"{CFG_DIR}/zsh/plugin/zsh-syntax-highlighting",]
        )

        subprocess.run(
            [
                "git",
                "clone",
                "https://github.com/zsh-users/zsh-autosuggestions",
                f"{CFG_DIR}/zsh/plugin/zsh-autosuggestions",
                "--quiet",
            ]
        )

        subprocess.run(
            [
                "git",
                "clone",
                "https://github.com/zsh-users/zsh-syntax-highlighting",
                f"{CFG_DIR}/zsh/plugin/zsh-syntax-highlighting",
                "--quiet",
            ]
        )

    elif args.list:
        print(data)


if __name__ == "__main__":
    main()
