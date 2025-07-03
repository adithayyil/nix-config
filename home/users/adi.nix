{ config, inputs, pkgs, lib, unstablePkgs, ... }:
{
  # User-specific configuration for adi

  # Additional packages for this user
  home.packages = with pkgs; [
    # Add user-specific packages here that aren't in the common modules
  ];

  # User-specific program configurations
  programs = {
    git = {
      enable = true;
      userName = "Adi";
      userEmail = "your-email@example.com"; # Update with actual email

      extraConfig = {
        init.defaultBranch = "main";
        push.default = "simple";
        pull.rebase = true;
      };
    };
  };

  # User-specific environment variables
  home.sessionVariables = {
    EDITOR = "hx";
    BROWSER = "zen";
  };
}
