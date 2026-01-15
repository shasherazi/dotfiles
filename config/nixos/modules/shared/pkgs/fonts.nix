{ pkgs, ... }:
let
  oxanium = pkgs.stdenvNoCC.mkDerivation {
    pname = "oxanium-font";
    version = "fontsource-current";
    src = pkgs.fetchzip {
      url = "https://r2.fontsource.org/fonts/oxanium@latest/download.zip";
      # First build: temporarily use lib.fakeSha256 to get the real hash
      sha256 = "sha256-QoPVzY57QQToa5+aBiveBT7qvXKHUxsTTH2+NkNOrqQ=";
      stripRoot = false;
    };
    installPhase = ''
      install -Dm444 -t $out/share/fonts/truetype \
      $(find . -type f -iname "*.ttf")
    '';
  };
in
{
  fonts = {
    fontconfig.enable = true;
    packages =
      with pkgs;
      [
        nerd-fonts.jetbrains-mono
        nerd-fonts.fira-code
        nerd-fonts.fira-mono
        noto-fonts
        noto-fonts-color-emoji
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
      ]
      ++ [ oxanium ];
  };

  environment.systemPackages = with pkgs; [
    font-manager
  ];
}
