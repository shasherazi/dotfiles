{ pkgs, ... }:
let
  # Nix downloads and unpacks these into the store
  McMojaveCursors = pkgs.fetchzip {
    url = "https://github.com/shasherazi/dotfiles/raw/refs/heads/main/assets/cursors/McMojaveCursors.tar.xz";
    sha256 = "sha256-9TOoPXE7fbcq1SilJc9/xhjn5Rz1S9pjQ3ojRb0qf6Y=";
    stripRoot = false;
  };

  PosyCursor = pkgs.fetchzip {
    url = "https://github.com/shasherazi/dotfiles/raw/refs/heads/main/assets/cursors/posy-cursor.tar.xz";
    sha256 = "sha256-R3YPV1VyFbTlJHvXTIOn6rq4Z3KCEQzSODcppSlsbbU=";
    stripRoot = false;
  };

  WhiteSurIcons = pkgs.fetchzip {
    url = "https://github.com/shasherazi/dotfiles/raw/refs/heads/main/assets/icons/WhiteSurIcons.tar.xz";
    sha256 = "sha256-PEbjZ2FDm8+NukAINfM0T4yKDVweMNPt2SiXY6DJIew=";
    stripRoot = false;
  };

  WhiteSurGtk = pkgs.fetchzip {
    url = "https://github.com/shasherazi/dotfiles/raw/refs/heads/main/assets/themes/WhiteSurDark.tar.xz";
    sha256 = "sha256-n+zeHMpyyay5sdekOTg5x1QRWNjZI3j0MAA2dwYYbPk=";
    stripRoot = false;
  };

  installThemes = pkgs.writeShellScript "install-themes" ''
    set -euo pipefail

    themes_dir="$HOME/.local/share/themes"
    icons_dir="$HOME/.local/share/icons"

    mkdir -p "$themes_dir" "$icons_dir"

    install_if_missing() {
      src="$1"
      dst="$2"

      if [ -d "$dst" ]; then
        echo "exists: $dst (skipping)"
        return 0
      fi

      echo "installing: $dst"
      mkdir -p "$(dirname "$dst")"

      # Copy contents without preserving ownership/perms from source
      ${pkgs.coreutils}/bin/cp -rT "$src" "$dst"

      # Ensure the user owns it and can delete it later
      ${pkgs.coreutils}/bin/chmod -R u+rwX "$dst"
    }

    # cursors
    install_if_missing "${McMojaveCursors}/McMojave-cursors" \
      "$icons_dir/McMojave-cursors"
    install_if_missing "${PosyCursor}/Posy_Cursor" \
      "$icons_dir/Posy_Cursor"

    # icons
    install_if_missing "${WhiteSurIcons}/WhiteSur" \
      "$icons_dir/WhiteSur"
    install_if_missing "${WhiteSurIcons}/WhiteSur-dark" \
      "$icons_dir/WhiteSur-dark"
    install_if_missing "${WhiteSurIcons}/WhiteSur-light" \
      "$icons_dir/WhiteSur-light"

    # themes
    install_if_missing "${WhiteSurGtk}/WhiteSur-Dark" \
      "$themes_dir/WhiteSur-Dark"
  '';
in
{
  systemd.user.services.install-themes-and-icons = {
    description = "Install themes/icons into ~/.themes and ~/.icons if missing";
    wantedBy = [ "default.target" ]; # run when user session starts
    serviceConfig = {
      Type = "oneshot";
      ExecStart = installThemes;
    };
  };
}
