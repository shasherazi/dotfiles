{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    afetch
    fastfetch
    macchina
    nerdfetch
    pfetch
    screenfetch
    ufetch
  ];
}

