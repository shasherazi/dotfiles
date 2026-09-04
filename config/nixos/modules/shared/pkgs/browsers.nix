{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    brave
    ungoogled-chromium
    firefox
    tor-browser
  ];
}
