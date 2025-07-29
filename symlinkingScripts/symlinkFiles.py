#!/usr/bin/env python

import os

DOTFILES_PATH = os.path.expanduser("~/dotfiles")


def symlinkFile(source, destination):
    source = os.path.join(DOTFILES_PATH, source)
    destination = os.path.join(os.path.expanduser("~"), destination)

    if os.path.exists(destination):
        os.remove(destination)
    elif os.path.islink(destination):
        os.unlink(destination)

    print(f"Symlinking {source} to {destination}")
    os.symlink(source, destination)


destinations = [
    ".gitconfig",
    ".p10k.zsh",
    ".zshrc",
    ".config/electron-flags.conf",
    ".config/kdeglobals"
]

sources = [
    "config/git/.gitconfig",
    "config/zsh/.p10k.zsh",
    "config/zsh/.zshrc",
    "config/electron-flags.conf",
    "config/kdeglobals"
]

for zippped in zip(sources, destinations):
    symlinkFile(*zippped)
