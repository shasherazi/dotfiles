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

  programs.hyprland.enable = true;
}
