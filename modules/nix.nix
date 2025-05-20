{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    npins 
  ];
  
  nix = {
    channel.enable = false;
    settings = {
      experimental-features = ["nix-command" "flakes"];
    };
  };
}
