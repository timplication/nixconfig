{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    helix
    texliveFull
    rustup
  ];  

  environment.variables.EDITOR = "hx";
}
