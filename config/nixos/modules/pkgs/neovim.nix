{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    fd
    ripgrep

    # lsp stuff
    black
    clang-tools
    emmet-language-server
    eslint_d
    python3Packages.flake8
    hyprls
    lua-language-server
    nil
    nixd
    prettierd
    ron-lsp
    stylua
    tailwindcss-language-server
    ty
    typescript-language-server
    vscode-json-languageserver
    vtsls
  ];
}
