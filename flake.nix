{
  description = "adi's nix-darwin system";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    
    # Nix Darwin
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Mac App Util for better macOS app integration
    mac-app-util = {
      url = "github:hraban/mac-app-util";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, mac-app-util, ... }:
  let
    inherit (self) outputs;
    stateVersion = "23.11";
    
    # Import our library functions
    lib = import ./lib { inherit inputs outputs stateVersion; };
    
    # Supported systems
    systems = [ "aarch64-darwin" "x86_64-darwin" ];
  in
  {
    # Custom library functions for reuse
    lib = lib;
    
    # Overlays for custom packages (empty for now)
    overlays = {
      default = final: prev: { };
    };
    
    # Darwin configurations
    darwinConfigurations = {
      "Adis-MacBook-Air" = lib.mkDarwin {
        hostname = "Adis-MacBook-Air";
        username = "adi";
        system = "aarch64-darwin";
      };
    };
    
    # Home Manager configurations (standalone)
    homeConfigurations = {
      "adi" = lib.mkHome {
        username = "adi";
        system = "aarch64-darwin";
      };
    };
    
    # Development shell
    devShells = nixpkgs.lib.genAttrs systems (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nixd  # Nix language server
            nixpkgs-fmt  # Nix formatter
          ];
        };
      }
    );
    
    # Expose packages for easy access
    packages = nixpkgs.lib.genAttrs systems (system: {
      # Remove the circular reference for now
      # default = self.darwinConfigurations."Adis-MacBook-Air".system;
    });
  };
}
