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
        
        # Create a wrapper script that sets up the config and runs neovim
        nvimWrapper = pkgs.writeShellScriptBin "nvim" ''
          export XDG_CONFIG_HOME="$HOME/.tmp/nvim-config"
          # Add our tools to the PATH
          export PATH="${pkgs.lib.makeBinPath extraPackages}:$PATH"
          mkdir -p "$XDG_CONFIG_HOME"
          cp -r ${./nvim} "$XDG_CONFIG_HOME/nvim"
          exec ${pkgs.neovim}/bin/nvim "$@"
        '';
      in
      {
        packages.default = nvimWrapper;
        
        apps.default = {
          type = "app";
          program = "${nvimWrapper}/bin/nvim";
        };

        # Development shell with all dependencies
        devShells.default = pkgs.mkShell {
          buildInputs = [ nvimWrapper ] ++ extraPackages;
        };

        # Home Manager configuration
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
