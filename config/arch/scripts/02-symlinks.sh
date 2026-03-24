#!/usr/bin/env bash

set -euo pipefail

echo "Starting dotfiles symlinking..."

DOTFILES="$HOME/dotfiles"

# Ensure the dotfiles repository actually exists before proceeding
if [ ! -d "$DOTFILES" ]; then
  echo "dotfiles: Directory not found at $DOTFILES. Please clone your dotfiles first."
  exit 1
fi

mkdir -p "$HOME/.config"

link_dir() {
  local src="$1"
  local dst="$2"

  if [ ! -e "$src" ]; then
    echo "dotfiles: missing src: $src (skipping)"
    return 0
  fi

  mkdir -p "$(dirname "$dst")"

  # If dst exists and is already correct symlink, do nothing.
  if [ -L "$dst" ]; then
    if [ "$(readlink -f "$dst")" = "$(readlink -f "$src")" ]; then
      echo "dotfiles: already linked $dst -> $src"
      return 0
    fi
    echo "dotfiles: WARNING - $dst is a symlink but points to $(readlink "$dst") instead of $src (skipping)"
    return 0
  fi

  # Don't clobber real directories/files.
  if [ -e "$dst" ]; then
    echo "dotfiles: WARNING - $dst exists and is a real file/directory (skipping to prevent data loss)"
    return 0
  fi

  ln -sf "$src" "$dst"
  echo "dotfiles: linked $dst -> $src"
}

link_file() {
  local src="$1"
  local dst="$2"

  if [ ! -f "$src" ]; then
    echo "dotfiles: missing file src: $src (skipping)"
    return 0
  fi

  mkdir -p "$(dirname "$dst")"

  # If dst exists and is already correct symlink, do nothing.
  if [ -L "$dst" ]; then
    if [ "$(readlink -f "$dst")" = "$(readlink -f "$src")" ]; then
      echo "dotfiles: already linked $dst -> $src"
      return 0
    fi
    echo "dotfiles: WARNING - $dst is a symlink but points to $(readlink "$dst") instead of $src (skipping)"
    return 0
  fi

  # Don't clobber real directories/files.
  if [ -e "$dst" ]; then
    echo "dotfiles: WARNING - $dst exists and is a real file/directory (skipping to prevent data loss)"
    return 0
  fi

  ln -sf "$src" "$dst"
  echo "dotfiles: linked $dst -> $src"
}

echo "Linking files in \$HOME..."
# ---- $HOME links (files) ----
link_file "$DOTFILES/config/git/.gitconfig" "$HOME/.gitconfig"
link_file "$DOTFILES/config/zsh/.zshrc" "$HOME/.zshrc"
link_file "$DOTFILES/config/zsh/.p10k.zsh" "$HOME/.p10k.zsh"
link_dir "$DOTFILES/config/zsh/.zsh_plugins" "$HOME/.zsh_plugins"

echo "Linking directories in ~/.config..."
# ---- ~/.config dirs ----
link_dir "$DOTFILES/config/alacritty" "$HOME/.config/alacritty"
link_dir "$DOTFILES/config/arch" "$HOME/.config/arch"
link_dir "$DOTFILES/config/dunst" "$HOME/.config/dunst"
link_dir "$DOTFILES/config/gammastep" "$HOME/.config/gammastep"
link_dir "$DOTFILES/config/hypr" "$HOME/.config/hypr"
link_dir "$DOTFILES/config/kitty" "$HOME/.config/kitty"
link_dir "$DOTFILES/config/mpd" "$HOME/.config/mpd"
link_dir "$DOTFILES/config/nixos" "$HOME/.config/nixos"
link_dir "$DOTFILES/config/nvim" "$HOME/.config/nvim"
link_dir "$DOTFILES/config/rmpc" "$HOME/.config/rmpc"
link_dir "$DOTFILES/config/rofi" "$HOME/.config/rofi"
link_dir "$DOTFILES/config/tmux" "$HOME/.config/tmux"
link_dir "$DOTFILES/config/waybar" "$HOME/.config/waybar"
link_dir "$DOTFILES/config/zathura" "$HOME/.config/zathura"

echo "Linking isolated files in ~/.config..."
# ---- ~/.config single files ----
link_file "$DOTFILES/config/electron-flags.conf" "$HOME/.config/electron-flags.conf"
link_file "$DOTFILES/config/kdeglobals" "$HOME/.config/kdeglobals"

echo "Symlinking complete!"
