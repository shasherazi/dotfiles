{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    brightnessctl
    cliphist
    gammastep
    grim
    hypridle
    hyprlock
    hyprpaper
    rofi
    slurp
    waybar
    wl-clipboard
    xdg-desktop-portal-gtk
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config = {
        common.default = [ "gtk" ];
        hyprland.default = [
          "gtk"
          "hyprland"
        ];
      };
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
      ];
    };
  };
}
