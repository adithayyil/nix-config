{
  description = "adi's nix-darwin system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    mac-app-util.url = "github:hraban/mac-app-util";
    mac-app-util.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, mac-app-util, ... }:
  let
    inherit (self) outputs;
    stateVersion = "24.11";
    libx = import ./lib { inherit inputs outputs stateVersion; };
  in
  {
    darwinConfigurations = {
      "Adis-MacBook-Air" = libx.mkDarwin { 
        hostname = "Adis-MacBook-Air"; 
        username = "adi";
      };
    };
    
    # Expose packages for easy access
    packages.aarch64-darwin.default = self.darwinConfigurations."Adis-MacBook-Air".system;
  };
}
