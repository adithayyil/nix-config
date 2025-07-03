{ ... }:
{
  # Dotfile management - link configuration files from the repository
  home.file = {
    ".config/fish".source = ../../home/fish;
    ".config/helix".source = ../../home/helix;
    ".config/kitty".source = ../../home/kitty;
    ".config/zathura".source = ../../home/zathura;
    ".config/aerospace".source = ../../home/aerospace;
    ".config/scdl/scdl.cfg".source = ../../home/scdl/scdl.cfg;
    ".ssh/config".source = ../../home/ssh/config;
    ".hushlogin".text = "";
  };
}
