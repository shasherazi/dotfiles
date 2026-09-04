{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    calibre
    gimp
    krita
    obs-studio
    syncplay
  ];
}
