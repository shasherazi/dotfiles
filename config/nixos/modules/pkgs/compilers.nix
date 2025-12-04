{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    cargo
    jdk
    gcc
    libgcc
    nodejs_24
    rustc
  ];
}

