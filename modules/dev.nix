{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    helix
    texliveFull
    rustup
    lldb
  ];  

  environment.variables.EDITOR = "hx";
}
