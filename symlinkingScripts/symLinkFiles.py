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
    ".zshrc",
    ".p10k.zsh",
    ".local/share/applications/google-chrome.desktop",
]

sources = [
    "config/zsh/.zshrc",
    "config/zsh/.p10k.zsh",
    "config/applications/google-chrome.desktop",
]

for zippped in zip(sources, destinations):
    symlinkFile(*zippped)
