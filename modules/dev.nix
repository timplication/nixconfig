{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    helix
    texliveFull
  ];  

  environment.variables.EDITOR = "hx";
}
