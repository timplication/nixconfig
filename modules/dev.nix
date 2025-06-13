{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Core Utils
    uutils-coreutils-noprefix
    ripgrep
    ripgrep-all
    tokei
  
    # Version Control
    git
    
    # Editor
    helix

    # TeX
    texliveFull

    # Rust 
    rustup
    lldb
    bacon

    # Julia
    julia

    # C/C++
    clang
  ];  

  environment.variables.EDITOR = "hx";
}
