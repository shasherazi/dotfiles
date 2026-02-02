{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    kdePackages.filelight
    keepassxc
    mindustry
    obsidian
    qucs-s
  ];
}
