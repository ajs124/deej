{
  description = "deej";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    gomod2nix = {
      url = "github:nix-community/gomod2nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
  };

  outputs = { self, nixpkgs, flake-utils, gomod2nix }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs { inherit system; };
      package = pkgs.callPackage ./package.nix {
        inherit (gomod2nix.legacyPackages.${system}) buildGoApplication;
      };
    in {
      packages = {
        default = package;
        deej = package;
      };

      # Add dependencies that are only needed for development
      devShells = {
        default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            go
            pkg-config
            graphviz
          ];
          buildInputs = with pkgs; [
            gtk3
            libappindicator-gtk3
            libayatana-appindicator
            webkitgtk
            pcre
          ];
        };
      };
    });
}
