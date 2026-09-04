{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    anki
    blender
    bruno
    kdePackages.filelight
    gparted
    gtkwave
    keepassxc
    kicad
    logisim-evolution
    obsidian
    kdePackages.partitionmanager
    qucs-s
    ngspice
    stremio-linux-shell
  ];
}
