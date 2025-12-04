{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bluetui
    cowsay
    fortune
    git
    unzip
    wl-clipboard
    syncthing
    zsh
  ];
}
