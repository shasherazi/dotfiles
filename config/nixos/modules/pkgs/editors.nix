{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    alpine # for pico
    nano
    neovim
    vim
    vscode
  ];
}
