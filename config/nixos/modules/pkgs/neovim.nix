{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neovim
    fd
    ripgrep

    # lsp stuff
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
    ty
    typescript-language-server
    vscode-json-languageserver
    vtsls
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
