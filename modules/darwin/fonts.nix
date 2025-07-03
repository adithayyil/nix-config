{ pkgs, ... }:
{
  # Font configuration
  fonts.packages = with pkgs; [
    # Nerd Fonts for terminal/development
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack
    nerd-fonts.iosevka
  ];
}
