{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    btop
    cowsay
    fortune
    lazygit
    tree
  ];
}
