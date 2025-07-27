{ ... }:
{
  # Dotfile management
  home.file = {
    ".config/fish".source = ../../home/fish;
    ".config/helix".source = ../../home/helix;
    ".config/kitty".source = ../../home/kitty;
    ".config/zathura".source = ../../home/zathura;
    ".config/aerospace".source = ../../home/aerospace;
    ".tmux".source = ../../home/tmux;
    ".tmux.conf".source = ../../home/tmux/tmux.conf;
    ".config/scdl/scdl.cfg".source = ../../home/scdl/scdl.cfg;
    ".ssh/config".source = ../../home/ssh/config;
    ".hushlogin".text = "";
  };

  # User-specific environment variables
  home.sessionVariables = {
    EDITOR = "hx";
    BROWSER = "zen";
  };
}
