{
  description = "A very basic flake";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          config = {
            allowBroken = false;
            allowUnfree = true;
          };

          inherit system;
        };
      in {
        defaultPackage = pkgs.hello;

        packages = import ./pkgs/top-level {inherit pkgs;};
      }
    );
}