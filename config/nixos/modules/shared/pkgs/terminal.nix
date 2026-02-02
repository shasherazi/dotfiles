{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    kitty
    kdePackages.konsole
    tmux
  ];
}
