{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    fd
    ripgrep
    # lsp stuff
    black
    clang-tools
    eslint_d
    python3Packages.flake8
    lua-language-server
    nixd
    prettierd
    stylua
    ty
    typescript-language-server
    vtsls
  ];
}
