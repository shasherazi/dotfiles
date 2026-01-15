# check if tmux is installed, install if not
if ! command -v tmux &>/dev/null; then
  echo "tmux not found, installing..."
  sudo pacman -S tmux --noconfirm --needed
else
  echo "tmux found, skipping..."
  exit 0
fi

# install tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# install tpm plugins
~/.tmux/plugins/tpm/bin/install_plugins
