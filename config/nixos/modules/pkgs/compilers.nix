{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    cargo
    gcc
    gnumake
    jdk
    libclang
    libgcc
    nodejs_24
    python3
    rustc
  ];
}

