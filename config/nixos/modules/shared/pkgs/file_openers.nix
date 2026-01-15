{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # file managers
    kdePackages.dolphin
    kdePackages.kio-extras # smth to do with dolphin
    nemo
    pcmanfm-qt

    # archives
    kdePackages.ark

    # music
    kdePackages.elisa

    # images
    kdePackages.gwenview

    # text
    kdePackages.kate

    # pdf
    kdePackages.okular

    # video
    mpv
    vlc

    # torrents
    qbittorrent
    kdePackages.kget

    # office (docs, sheets, slides)
    libreoffice-still
  ];
}
