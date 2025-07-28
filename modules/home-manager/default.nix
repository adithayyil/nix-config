{
  imports = [
    ./packages.nix
    ./programs.nix
    ./dotfiles.nix
  ];

  # Enable mac-app-util for proper app linking
  disabledModules = [ "targets/darwin/linkapps.nix" ];
}
