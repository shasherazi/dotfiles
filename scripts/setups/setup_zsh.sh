# powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh_plugins/powerlevel10k

# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh_plugins/zsh-autosuggestions

# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh_plugins/zsh-syntax-highlighting

# sudo-plugin
mkdir ~/.zsh_plugins/sudo-plugin
curl -L https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/refs/heads/master/plugins/sudo/sudo.plugin.zsh > ~/.zsh_plugins/sudo-plugin/sudo.plugin.zsh

# catppuccin_mocha-zsh-syntax-highlighting
git clone https://github.com/catppuccin/zsh-syntax-highlighting.git ~/.zsh_plugins/catppuccin_mocha-zsh-syntax-highlighting

# change shell to zsh
chsh -s $(which zsh) $(whoami)
