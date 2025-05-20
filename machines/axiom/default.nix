{
  config,
  lib,
  pkgs,
  ...
}: {
  ##         ##
  ## Imports ##
  ##         ##
 
  # System-level module imports
  imports = [
    ./hardware.nix
    ../../modules/nix.nix
    ../../modules/locale.nix
    ../../modules/users.nix
    ../../modules/dev.nix
    ../../modules/desktop.nix
  ];


  ##               ##
  ## Configuration ##
  ##               ##

  # Boot straight into the user, we already enter a password on boot to decrypt the drives which use LUKS
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "niri-session";
        user = "tim";
      };
    };
  };

  
  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  # Hostname
  networking.hostName = "axiom";

  # This machine runs dualboot with Windows, important for system time reasons.
  tim.locale.dualboot = true;

  # These values determine the NixOS and home-manager releases from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # these values at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
