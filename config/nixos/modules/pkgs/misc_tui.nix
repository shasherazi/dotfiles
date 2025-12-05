{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    cowsay
    fastfetch
    fortune
    lazygit
  ];
}
