{ inputs, pkgs, unstablePkgs, ... }:
{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # System-level packages (only essential system tools)
  environment.systemPackages = with pkgs; [
    # Essential system tools only
    curl
    wget
    git
  ];
}