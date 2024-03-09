{
  description = "Environment of Map-Derivada: Julia & Python3";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let 
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells = rec {
          default = import ./shell.nix { inherit pkgs; };
        }; 
      }
    );
}