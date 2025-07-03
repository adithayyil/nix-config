# Common host configuration
{ hostname, username, ... }:
{
  # Set the primary user
  users.users.${username} = {
    home = "/Users/${username}";
    shell = "/run/current-system/sw/bin/fish";
  };

  # Set hostname
  networking.hostName = hostname;
  networking.computerName = hostname;
  networking.localHostName = hostname;

  # Enable TouchID for sudo
  security.pam.enableSudoTouchId = true;
}
