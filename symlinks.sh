DOTFILES=~/dotfiles

dirsToRemove=(
    .local/share/plank
    scripts
    .config/kitty
    .config/polybar
    .config/bspwm
    .config/nvim
    .config/picom
    .config/rofi
    .config/sxhkd
    .config/dunst
    .config/eww
    .config/zathura
)

dirsInDotfiles=(
    plank/plank
    scripts
    kitty
    polybar
    bspwm
    nvim
    picom
    rofi
    sxhkd
    dunst
    eww
    zathura
)

for index in ${!dirsToRemove[*]}; do
    rm -r $HOME/${dirsToRemove[$index]}
    ln -sf $DOTFILES/${dirsInDotfiles[$index]} $HOME/${dirsToRemove[$index]}
done
