DOTFILES=~/dotfiles

dirsToRemove=(
    .icons
    .themes
    .local/share/plank
    scripts
)

dirsInDotfiles=(
    gnome/.icons
    gnome/.themes
    plank/plank
    scripts
)

for index in ${!dirsToRemove[*]}; do
    rm -r $HOME/${dirsToRemove[$index]}
    ln -sf $DOTFILES/${dirsInDotfiles[$index]} $HOME/${dirsToRemove[$index]}
done
