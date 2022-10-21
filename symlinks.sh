DOTFILES=~/dotfiles

dirsToRemove=(
    .icons
    .themes
    .local/share/plank
    scripts
    .config/kitty
    .config/polybar
)

dirsInDotfiles=(
    gnome/.icons
    gnome/.themes
    plank/plank
    scripts
    kitty
    polybar
)

for index in ${!dirsToRemove[*]}; do
    rm -r $HOME/${dirsToRemove[$index]}
    ln -sf $DOTFILES/${dirsInDotfiles[$index]} $HOME/${dirsToRemove[$index]}
done
