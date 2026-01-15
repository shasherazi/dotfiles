{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lutris
    gamescope
    mindustry-wayland
    steam-run
    wine
  ];

  programs.steam.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
