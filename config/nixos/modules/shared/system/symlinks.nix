{ pkgs, ... }:
let
  linkDotfiles = pkgs.writeShellScript "link-dotfiles" ''
    set -euo pipefail

    DOTFILES="$HOME/dotfiles"

    if [ ! -d "$DOTFILES" ]; then
      echo "dotfiles: dir not found: $DOTFILES"
      exit 0
    fi

    mkdir -p "$HOME/.config"

    link_dir() {
      src="$1"
      dst="$2"

      if [ ! -e "$src" ]; then
        echo "dotfiles: missing src: $src (skipping)"
        return 0
      fi

      mkdir -p "$(dirname "$dst")"

      # If dst exists and is already correct symlink, do nothing.
      if [ -L "$dst" ]; then
        if [ "$(readlink -f "$dst")" = "$(readlink -f "$src")" ]; then
          return 0
        fi
        echo "dotfiles: $dst is a symlink but points to $(readlink "$dst") (skipping)"
        return 0
      fi

      # Don't clobber real directories/files.
      if [ -e "$dst" ]; then
        echo "dotfiles: $dst exists and is not a symlink (skipping)"
        return 0
      fi

      ln -sf "$src" "$dst"
      echo "dotfiles: linked $dst -> $src"
    }

    link_file() {
      src="$1"
      dst="$2"

      if [ ! -f "$src" ]; then
        echo "dotfiles: missing file src: $src (skipping)"
        return 0
      fi

      mkdir -p "$(dirname "$dst")"

      if [ -L "$dst" ]; then
        if [ "$(readlink -f "$dst")" = "$(readlink -f "$src")" ]; then
          return 0
        fi
        echo "dotfiles: $dst is a symlink but points to $(readlink "$dst") (skipping)"
        return 0
      fi

      if [ -e "$dst" ]; then
        echo "dotfiles: $dst exists and is not a symlink (skipping)"
        return 0
      fi

      ln -sf "$src" "$dst"
      echo "dotfiles: linked $dst -> $src"
    }

    # ---- $HOME links (files) ----
    link_file "$DOTFILES/config/git/.gitconfig" "$HOME/.gitconfig"
    link_file "$DOTFILES/config/zsh/.zshrc" "$HOME/.zshrc"
    link_file "$DOTFILES/config/zsh/.p10k.zsh" "$HOME/.p10k.zsh"
    link_dir "$DOTFILES/config/zsh/.zsh_plugins" "$HOME/.zsh_plugins"

    # ---- ~/.config dirs ----
    link_dir "$DOTFILES/config/alacritty" "$HOME/.config/alacritty"
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

    # ---- ~/.config single files ----
    link_file "$DOTFILES/config/electron-flags.conf" \
      "$HOME/.config/electron-flags.conf"
    link_file "$DOTFILES/config/kdeglobals" \
      "$HOME/.config/kdeglobals"
  '';
in
{
  systemd.user.services.link-dotfiles = {
    description = "Symlink ~/dotfiles into place";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = linkDotfiles;
    };
  };
}
