DOTFILES=~/dotfiles

dirsToRemove=(
    .icons
    .themes
    .spicetify
    .zshrc
    .p10k.zsh
    .oh-my-zsh
    .local/share/plank
    .local/share/ulauncher
)

dirsInDotfiles=(
    gnome/.icons
    gnome/.themes
    spicetify/.spicetify
    zsh/.zshrc
    zsh/.p10k.zsh
    zsh/.oh-my-zsh
    plank/plank
    ulauncher/ulauncher
)

for index in ${!dirsToRemove[*]}; do
    rm -r $HOME/${dirsToRemove[$index]}
    ln -sf $DOTFILES/${dirsInDotfiles[$index]} $HOME/${dirsToRemove[$index]}
done
