{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    afetch
    fastfetch
    macchina
    neofetch
    nerdfetch
    pfetch
    screenfetch
    ufetch
  ];
}

