{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bluetui
    git
    unzip
    wl-clipboard
    syncthing
    zsh
  ];
}
