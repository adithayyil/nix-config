{ inputs, outputs, stateVersion, ... }:
let
  inherit (inputs.nixpkgs) lib;
in
{
  # Create a Darwin system configuration
  mkDarwin = { hostname, username ? "adi", system ? "aarch64-darwin" }:
    let
      unstablePkgs = inputs.nixpkgs-unstable.legacyPackages.${system};
      hostConfigPath = ./../hosts/darwin/${hostname};
      hostConfig =
        if builtins.pathExists hostConfigPath
        then hostConfigPath
        else { };
    in
    inputs.nix-darwin.lib.darwinSystem {
      inherit system;

      specialArgs = {
        inherit inputs outputs hostname username unstablePkgs stateVersion;
      };

      modules = [
        # Inline the essential Darwin configuration
        {
          # Primary user configuration
          system.primaryUser = username;

          # User configuration
          users.users.${username} = {
            home = "/Users/${username}";
            shell = "/run/current-system/sw/bin/fish";
          };

          # Set hostname
          networking.hostName = hostname;
          networking.computerName = hostname;
          networking.localHostName = hostname;

          # Nix configuration
          nix = {
            settings = {
              experimental-features = [ "nix-command" "flakes" ];
              warn-dirty = false;
              trusted-users = [ "@admin" ];
            };

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

          # System state version
          system.stateVersion = 5;

          # Shell configuration
          programs.fish.enable = true;
          programs.zsh.enable = true;

          # Font configuration (system level)
          fonts.packages = with unstablePkgs; [
            nerd-fonts.fira-code
            nerd-fonts.jetbrains-mono
            nerd-fonts.hack
            nerd-fonts.iosevka
          ];

          # Default macOS system settings
          system.defaults = {
            dock = {
              autohide = true;
              orientation = "bottom";
              showhidden = true;
              mineffect = "genie";
              launchanim = true;
              show-process-indicators = true;
              tilesize = 48;
              static-only = true;
            };

            finder = {
              AppleShowAllExtensions = true;
              FXEnableExtensionChangeWarning = false;
              CreateDesktop = false;
              ShowPathbar = true;
              ShowStatusBar = true;
              FXPreferredViewStyle = "clmv";
              FXDefaultSearchScope = "SCcf";
            };

            trackpad = {
              Clicking = true;
              TrackpadThreeFingerDrag = true;
            };

            NSGlobalDomain = {
              AppleShowAllExtensions = true;
              InitialKeyRepeat = 14;
              KeyRepeat = 1;

              NSAutomaticCapitalizationEnabled = false;
              NSAutomaticDashSubstitutionEnabled = false;
              NSAutomaticPeriodSubstitutionEnabled = false;
              NSAutomaticQuoteSubstitutionEnabled = false;
              NSAutomaticSpellingCorrectionEnabled = false;
            };

            loginwindow = {
              GuestEnabled = false;
              SHOWFULLNAME = false;
            };
          };

          # System-level packages (minimal)
          environment.systemPackages = with unstablePkgs; [
            # Only essential system-wide tools here
          ];
        }

        # Import system-level modules here
        ./../modules/darwin/homebrew.nix

        # Host-specific configuration
        hostConfig

        # Home Manager integration
        inputs.home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            
            # ADD THIS: Pass extraSpecialArgs to home-manager
            extraSpecialArgs = {
              inherit inputs outputs unstablePkgs;
            };
            
            # Import the home-manager modules
            users.${username} = {
              imports = [ ./../modules/home-manager/default.nix ];
              
              # Set required home-manager options
              home = {
                inherit username stateVersion;
                homeDirectory = "/Users/${username}";
              };
            };
          };
        }
      ];
    };

  # Create a standalone Home Manager configuration
  mkHome = { username, system ? "aarch64-darwin" }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${system};

      extraSpecialArgs = {
        inherit inputs outputs;
        unstablePkgs = inputs.nixpkgs-unstable.legacyPackages.${system};
      };

      modules = [
        {
          home = {
            inherit username stateVersion;
            homeDirectory = "/Users/${username}";
          };
        }
        ./../modules/home-manager/default.nix
      ];
    };
}
