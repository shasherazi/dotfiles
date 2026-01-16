{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    alpine # for pico
    nano
    vim
    vscode
  ];
}
