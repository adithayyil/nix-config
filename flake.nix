{
  description = "adi's nix-darwin system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    mac-app-util.url = "github:hraban/mac-app-util";
    mac-app-util.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, mac-app-util, ... }:
  let
    inherit (self) outputs;
    stateVersion = "23.11";
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
