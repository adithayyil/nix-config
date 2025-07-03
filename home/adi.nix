{ config, inputs, pkgs, lib, unstablePkgs, ... }:
{
  home.stateVersion = "23.11";

  # Git configuration
  programs.git = {
    enable = true;
    userName = "Adi";  # Replace with your name
    userEmail = "your.email@example.com";  # Replace with your email
    diff-so-fancy.enable = true;
    lfs.enable = true;
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      merge = {
        conflictStyle = "diff3";
      };
      pull = {
        rebase = true;
      };
      core = {
        editor = "nvim";
      };
    };
  };

  # Shell configuration
  programs.fish = {
    enable = true;
    shellAliases = {
      ll = "eza -la";
      la = "eza -la";
      ls = "eza";
      cat = "bat";
      cd = "z";
      grep = "rg";
      find = "fd";
      du = "dust";
      df = "duf";
      top = "btop";
      # Nix shortcuts
      rebuild = "darwin-rebuild switch --flake /etc/nix-darwin";
      nix-gc = "nix-collect-garbage -d";
      nix-search = "nix search nixpkgs";
    };
    functions = {
      # Quick git functions
      gaa = "git add .";
      gc = "git commit -m";
      gp = "git push";
      gl = "git pull";
      gs = "git status";
      gd = "git diff";
    };
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
  };

  # Starship prompt
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      format = "$all$character";
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
      git_branch = {
        format = "[$symbol$branch]($style) ";
        symbol = " ";
      };
      nix_shell = {
        format = "[$symbol$state( \($name\))]($style) ";
        symbol = " ";
      };
    };
  };

  # Modern CLI tools
  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
      style = "numbers,changes,header";
    };
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    git = true;
    icons = "auto";
    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    defaultOptions = [
      "--height 40%"
      "--layout=reverse"
      "--border"
      "--color=16"
    ];
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.ripgrep = {
    enable = true;
    arguments = [
      "--smart-case"
      "--follow"
      "--color=never"
    ];
  };

  # Direnv for automatic environment loading
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Tmux configuration
  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    prefix = "C-a";
    historyLimit = 10000;
    extraConfig = ''
      # Mouse support
      set -g mouse on
      
      # Split panes using | and -
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %
      
      # Switch panes using Alt-arrow without prefix
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D
      
      # Start windows and panes at 1, not 0
      set -g base-index 1
      setw -g pane-base-index 1
      
      # Reload config file
      bind r source-file ~/.tmux.conf
    '';
  };

  # Neovim configuration (basic)
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraConfig = ''
      set number
      set relativenumber
      set expandtab
      set tabstop=2
      set shiftwidth=2
      set smartindent
      set wrap
      set smartcase
      set noswapfile
      set nobackup
      set undodir=~/.vim/undodir
      set undofile
      set incsearch
      set scrolloff=8
      set colorcolumn=80
      
      " Set leader key
      let mapleader = " "
      
      " Quick save
      nnoremap <leader>w :w<CR>
      
      " Quick quit
      nnoremap <leader>q :q<CR>
    '';
  };

  # SSH configuration
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
        AddKeysToAgent yes
        UseKeychain yes
        IdentitiesOnly yes
    '';
  };

  # GPG
  programs.gpg.enable = true;

  # Home directory dotfiles
  home.file = {
    ".hushlogin".text = ""; # Disable login message
  };
}
