{ config, inputs, pkgs, lib, unstablePkgs, ... }:
{
  home.stateVersion = "23.11";

  # Home packages
  home.packages = with pkgs; [
    kitty
    iina
    
    zathura

    # Fonts
    nerd-fonts.fira-code
    
    # CLI Tools (complement the programs.* configs below)
    fd
    dust
    duf
    btop
  ];

  # Use real config files/folders from home directory
  home.file = {
    ".config/fish".source = ./fish;
    ".config/helix".source = ./helix;
    ".config/kitty".source = ./kitty;
    ".config/zathura".source = ./zathura;
    ".ssh/config".source = ./ssh/config;
    ".scdl.cfg".source = ./scdl/scdl.cfg;
    ".hushlogin".text = "";
  };
}
