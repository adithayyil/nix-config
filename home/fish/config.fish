if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -gx EDITOR hx
abbr -a -- uni 'cd /Users/adi/Library/CloudStorage/OneDrive-UniversityofWaterloo/University/'

set -x DBUS_SESSION_BUS_ADDRESS unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET

if test (uname) = Darwin
    fish_add_path --prepend --global "$HOME/.nix-profile/bin" /nix/var/nix/profiles/default/bin /run/current-system/sw/bin
end
