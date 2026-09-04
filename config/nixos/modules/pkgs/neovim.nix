{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neovim
    fd
    ripgrep

    # lsp stuff
    arduino-language-server
    astro-language-server
    bash-language-server
    black
    emmet-language-server
    eslint_d
    python3Packages.flake8
    hyprls
    lua-language-server
    markdownlint-cli
    nil
    nixd
    prettierd
    ron-lsp
    stylua
    shfmt
    shellcheck
    tailwindcss-language-server
    tree-sitter
    ty
    typescript-language-server
    vhdl-ls
    vscode-json-languageserver
    vtsls
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
