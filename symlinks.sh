DOTFILES=~/dotfiles

dirsToRemove=(
    .icons
    .themes
    .local/share/plank
)

dirsInDotfiles=(
    gnome/.icons
    gnome/.themes
    plank/plank
)

for index in ${!dirsToRemove[*]}; do
    rm -r $HOME/${dirsToRemove[$index]}
    ln -sf $DOTFILES/${dirsInDotfiles[$index]} $HOME/${dirsToRemove[$index]}
done
