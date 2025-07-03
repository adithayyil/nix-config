{ ... }:
{
  # Program configurations using home-manager's built-in modules
  programs = {
    # Git configuration
    git = {
      enable = true;
      userName = "adithayyil";
      userEmail = "adithayyil@icloud.com";
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
