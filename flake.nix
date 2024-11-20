{
  description = "Neovim configuration with Lua";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        # Import the packages list
        extraPackages = import ./packages.nix { inherit pkgs; };
      in
      {
        homeManagerModules.default = { config, lib, pkgs, ... }: {
          home.packages = [ pkgs.neovim ] ++ extraPackages;
          
          home.file.".config/nvim" = {
            mode = 644;
            source = ./nvim;
            recursive = true;
          };
        };
      }
    );
}
