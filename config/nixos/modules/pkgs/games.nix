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
}
