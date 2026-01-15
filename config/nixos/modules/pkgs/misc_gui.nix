{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    kdePackages.filelight
    keepassxc
    obsidian
    qucs-s
  ];
}
