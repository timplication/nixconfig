{ config, pkgs, lib, ... }:
let
  iosevka-ss18 = pkgs.iosevka-bin.override { variant = "SS18"; }; 
  iosevka-aile = pkgs.iosevka-bin.override { variant = "Aile"; }; 
  iosevka-etoile = pkgs.iosevka-bin.override { variant = "Etoile"; };
in {
  fonts.packages = with pkgs; [
    iosevka-ss18
    iosevka-aile
    iosevka-etoile
    libertine
    # corefonts
    roboto
    open-sans
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji
    noto-fonts-extra
    twitter-color-emoji
    font-awesome
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ "Iosevka Etoile" "Libertine" "Noto Serif" ];
      sansSerif = [ "Iosevka Aile" "Roboto" "Noto Sans" ];
      monospace = [ "Iosevka SS18" "Noto Sans Mono" ];
      emoji = [ "Twitter Color Emoji" "Font Awesome" ];
    };
  };
}
