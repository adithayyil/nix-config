{ inputs, outputs, stateVersion, ... }:
let
  helpers = import ./helpers.nix { inherit inputs outputs stateVersion; };
in
{
  # Export all helper functions
  inherit (helpers) mkDarwin mkHome;
  
  # System configurations
  systems = {
    aarch64-darwin = "aarch64-darwin";
    x86_64-darwin = "x86_64-darwin";
  };
}
