{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    mpv
    gimp
    nicotine-plus
    obs-studio
    puddletag
    qbittorrent
  ];
}

