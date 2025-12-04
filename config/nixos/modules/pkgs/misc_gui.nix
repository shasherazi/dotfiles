{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    keepassxc
    qucs-s
    steam-run
    kdePackages.filelight
  ];
}

