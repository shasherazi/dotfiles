{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (lutris.override {
      extraPkgs =
        pkgs: with pkgs; [
          libadwaita
          gtk4
        ];
    })
    gamescope
    mindustry-wayland
    steam-run
    wine
    winetricks
  ];

  programs.steam.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
