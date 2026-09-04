{ pkgs, ... }:
let
  oxanium = pkgs.stdenvNoCC.mkDerivation {
    pname = "oxanium-font";
    version = "fontsource-current";
    src = pkgs.fetchzip {
      url = "https://r2.fontsource.org/fonts/oxanium@latest/download.zip";
      # First build: temporarily use lib.fakeSha256 to get the real hash
      sha256 = "sha256-jAMYUPMbDVkIOhCUf1Z+rJRXrJFzzbpxkJdf2GXhuog=";
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
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [
          "Noto Serif"
          "Noto Nastaliq Urdu"
          "Gulzar"
        ];
        sansSerif = [
          "Noto Sans"
          "Noto Nastaliq Urdu"
          "Gulzar"
        ];
        monospace = [ "JetBrainsMono Nerd Font" ];
      };
    };
    packages =
      with pkgs;
      [
        google-fonts
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
