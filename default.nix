let
  # Nix channels and packages are managed by npins.
  sources = import ./npins;
  pkgs = import sources.nixpgs {};

  mkSystem = machineModule: {
    system ? "x86_64-linux"     
  }: import "${sources.nixpkgs}/nixos/lib/eval-config.nix" {
    inherit system;
    specialArgs = { inherit sources; };
    modules = [
      (import "${sources.lix-module}/module.nix" {
        lix = sources.lix // { rev = sources.lix.revision; };
      })

      {
        nixpkgs.flake.source = sources.nixpkgs;
        system.nixos.revision = sources.nixpkgs.revision;
      }

      # home-manager
      "${sources.home-manager}/nixos"
 
      # Main Module
      machineModule
    ];
  };
in
{
  "axiom" = mkSystem ./machines/axiom;
}
