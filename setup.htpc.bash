#!/usr/bin/bash
# Setup:
# Add imports.desktop.nix as ./imports.htpc.nix to imports section of the configuration.nix file in /etc/nixos/
# Usage:
# Run the following command: curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/setup.htpc.bash | bash

cd /etc/nixos

# kernel
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/kernel.nix -O

# channel
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/channel.unstable.nix -O

# desktop
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/desktop.htpc.nix -O

# hardware
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/hardware.audio.nix -O
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/hardware.radeon.nix -O
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/hardware.bluetooth.nix -O
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/hardware.razer.nix -O

# networking
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/networking.nix -O

# services
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/services.sunshine.nix -O
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/services.openrgb.nix -O
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/services.steam.nix -O

# packages
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/packages.htpc.nix -O

# imports
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/imports.htpc.nix -O

# other
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/customizations.nix -O

# rebuild
nixos-rebuild --upgrade-all boot
exit
