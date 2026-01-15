{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gimp
    obs-studio
  ];
}
