{ pkgs, ... }:
{
  # User packages - tools and applications for development and daily use
  home.packages = with pkgs; [
    # Development tools
    # fd
    # ripgrep
    # dust
    # duf
    # btop
    # tree
    # jq
    # yq
    
    # Terminal enhancements
    fish
    
    # File utilities
    # unzip
    # p7zip
    
    # Network tools
    # curl
    # wget
    
    # Version control
    # git
    # gh
    
    # Media
    iina
    
    # Productivity
    kitty
    zathura
  ];
}
