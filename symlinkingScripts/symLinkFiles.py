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
    ".config/chromium-flags.conf",
    ".gitconfig",
    ".local/bin/lfub",
    ".p10k.zsh",
    ".zshrc",
]

sources = [
    "config/chromium-flags.conf",
    "config/git/.gitconfig",
    ".local/bin/lfub",
    "config/zsh/.p10k.zsh",
    "config/zsh/.zshrc",
]

for zippped in zip(sources, destinations):
    symlinkFile(*zippped)
