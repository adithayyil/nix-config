{ ... }:
{
  # Nix configuration
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
      auto-optimise-store = true;
      trusted-users = [ "@admin" ];
    };

    # Automatic optimization and garbage collection
    optimise.automatic = true;
    channel.enable = false;

    gc = {
      automatic = true;
      interval = { Hour = 3; Minute = 15; };
      options = "--delete-older-than 7d";
    };
  };

  # Allow unfree packages globally
  nixpkgs.config.allowUnfree = true;
}
