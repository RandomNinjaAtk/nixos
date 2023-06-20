#!/usr/bin/bash
# Setup:
# Add imports.desktop.nix as ./desktop.nix to imports section of the configuration.nix file in /etc/nixos/
# Usage:
# Run the following command: curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/desktop.bash | bash

cd /etc/nixos

# get config
curl -s https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/desktop.nix -O
echo "Done"

# rebuild
echo "Performing NixOS garbage collection, older than 5 days..."
nix-collect-garbage --delete-older-than 5d 1> /dev/null
echo "Done"
echo "Performing NixOS Rebuild, Upgrade and Boot..."
nixos-rebuild --upgrade-all boot 1> /dev/null
echo "Done"

echo "Reboot system for changes to take affect..."
echo "Exiting...."
exit
