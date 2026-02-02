{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    calibre
    gimp
    obs-studio
  ];
}
