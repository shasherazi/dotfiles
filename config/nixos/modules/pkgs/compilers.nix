{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    arduino-cli
    cargo
    llvmPackages.clang
    llvmPackages.clang-tools
    llvmPackages.lldb
    gcc
    ghdl
    gnumake
    jdk
    libgcc
    nodejs_24
    python3
    rustc
    typescript
  ];
}
