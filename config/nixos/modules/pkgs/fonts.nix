{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}

