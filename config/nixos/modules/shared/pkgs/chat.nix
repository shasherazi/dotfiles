{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    iamb
    vesktop
  ];
}
