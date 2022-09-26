DOTFILES=~/dotfiles

rm -r ~/.icons
ln -sf $DOTFILES/gnome/.icons ~/.icons

rm -r ~/.themes
ln -sf $DOTFILES/gnome/.themes ~/.themes

rm -r ~/.spicetify
ln -sf $DOTFILES/spicetify/.spicetify ~/.spicetify

rm -r ~/.zshrc
ln -sf $DOTFILES/zsh/.zshrc ~/.zshrc

rm -r ~/.p10k.zsh
ln -sf $DOTFILES/zsh/.p10k.zsh ~/.p10k.zsh

rm -r ~/.oh-my-zsh
ln -sf $DOTFILES/zsh/.oh-my-zsh ~/.oh-my-zsh

rm -r ~/.local/share/plank
ln -sf $DOTFILES/plank/plank ~/.local/share/plank

rm -r ~/.local/share/ulauncher
ln -sf $DOTFILES/ulauncher/ulauncher ~/.local/share/ulauncher
