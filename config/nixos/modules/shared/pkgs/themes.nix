{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nwg-look
    kdePackages.qt6ct
    kdePackages.qtstyleplugin-kvantum
  ];
}
