{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # (lutris.override {
    #   extraPkgs =
    #     pkgs: with pkgs; [
    #       libadwaita
    #       gtk4
    #     ];
    # })
    # gamescope
    steam-run
    # wine
    # winetricks
  ];
}
