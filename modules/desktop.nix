{ config, pkgs, ... }:
{
  imports = [
    ./fonts.nix
  ];

  environment.systemPackages = with pkgs; [
    # Desktop Environment Facilities
    niri           # compositor
    fuzzel         # app launcher
    waybar         # status bar
    dunst          # notification handler
    libnotify      # facilities for sending notifications 
    wl-clipboard   # clipboard integration

    # TUI applications
    spotify-player

    # GUI Applications
    ghostty
    firefox-wayland
    papers
    nautilus
    spotify
    obsidian
  ];

  environment.variables."GDK_DEBUG" = "";
  environment.variables."GDK_DISABLE" = "";
  environment.variables."GSK_RENDERER" = "vulkan";

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.niri.enable = true;
 
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    wireplumber.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam.services.hyprlock = {};
  };
}
