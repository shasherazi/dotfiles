{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    cargo
    llvmPackages.clang
    llvmPackages.clang-tools
    llvmPackages.lldb
    gcc
    gnumake
    jdk
    libgcc
    nodejs_24
    python3
    rustc
  ];
}
