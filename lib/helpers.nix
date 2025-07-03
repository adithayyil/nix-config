{ inputs, outputs, stateVersion, ... }:
{
  mkDarwin = { hostname, username ? "adi", system ? "aarch64-darwin" }:
  let
    inherit (inputs.nixpkgs) lib;
    unstablePkgs = inputs.nixpkgs-unstable.legacyPackages.${system};
    customConfPath = ./../hosts/darwin/${hostname};
    customConf = if builtins.pathExists (customConfPath) then (customConfPath + "/default.nix") else ./../hosts/common/darwin-common.nix;
  in
    inputs.nix-darwin.lib.darwinSystem {
      specialArgs = { inherit system inputs outputs hostname username unstablePkgs; };
      modules = [
        ../hosts/common/common-packages.nix
        ../hosts/common/darwin-common.nix
        customConf
        {
          nixpkgs.overlays = [
            # Add any overlays here if needed
          ];
        }
        inputs.home-manager.darwinModules.home-manager {
          networking.hostName = hostname;
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.${username} = { 
            imports = [ 
              ./../home/${username}.nix 
              inputs.mac-app-util.homeManagerModules.default
            ]; 
          };
        }
        inputs.mac-app-util.darwinModules.default
      ];
    };
}
