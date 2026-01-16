{
  description = "Modern Qt6 GUI tool for managing default applications on Linux";

  nixConfig = {
    extra-substituters = [ "https://sda-qt6.cachix.org" ];
    extra-trusted-public-keys = [ "sda-qt6.cachix.org-1:f+mZPJwYQKpzaAdGWj2DfdHV5uEjnYx1ZoAWfZfEGoA=" ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.default = pkgs.qt6.callPackage ./nix/package.nix { };

        devShells.default = pkgs.mkShell {
          inputsFrom = [ self.packages.${system}.default ];
          buildInputs = [
            pkgs.gdb
            pkgs.clang-tools
          ];

          shellHook = ''
            echo "SelectDefaultApplication-Qt6 development environment"
          '';
        };
      });
}
