{ inputs, outputs, stateVersion }:
{
  inherit (import ./helpers.nix { inherit inputs outputs stateVersion; }) mkDarwin;
}
