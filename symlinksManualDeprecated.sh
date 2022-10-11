DOTFILES=~/dotfiles

rm -r ~/.icons
ln -sf $DOTFILES/gnome/.icons ~/.icons

rm -r ~/.themes
ln -sf $DOTFILES/gnome/.themes ~/.themes

rm -r ~/.local/share/plank
ln -sf $DOTFILES/plank/plank ~/.local/share/plank
