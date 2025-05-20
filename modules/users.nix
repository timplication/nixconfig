{ config, ... }:
{
  config = {
    users.users."tim" = {
      isNormalUser = true;
      description = "tim";
      extraGroups = [ "wheel" ];
    }; 

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users."tim" = {
        imports = [ ./home.nix ];
        config = {
          programs.home-manager.enable = true;
          home = {
            stateVersion = "24.11";
            username = "tim";
            homeDirectory = "/home/tim";
          };
        };
      };
    };
  };
}
 
