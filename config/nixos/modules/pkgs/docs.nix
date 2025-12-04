{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    libreoffice-still
    obsidian
  ];
}
