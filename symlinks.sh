DOTFILES=~/dotfiles

dirsToRemove=(
    .icons
    .themes
    .local/share/plank
    scripts
    .config/kitty
    .config/polybar
    .config/bspwm
    .config/nvim
    .config/picom
    .config/rofi
    .config/sxhkd
)

dirsInDotfiles=(
    gnome/.icons
    gnome/.themes
    plank/plank
    scripts
    kitty
    polybar
    bspwm
    nvim
    picom
    rofi
    sxhkd
)

for index in ${!dirsToRemove[*]}; do
    rm -r $HOME/${dirsToRemove[$index]}
    ln -sf $DOTFILES/${dirsInDotfiles[$index]} $HOME/${dirsToRemove[$index]}
done
