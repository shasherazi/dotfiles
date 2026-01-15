{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    firefox
    floorp-bin
    brave
  ];
}
