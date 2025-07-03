{ ... }:
{
  # Program configurations using home-manager's built-in modules
  programs = {
    # Git configuration
    git = {
      enable = true;
      # Add your git config here if needed
    };
    
    # Fish shell configuration
    fish = {
      enable = true;
      # Additional fish config can go here
    };
    
    # Starship prompt
    starship = {
      enable = true;
      # Add starship config here if needed
    };
    
    # Helix editor
    helix = {
      enable = true;
      # Additional helix config can go here
    };
  };
}
