#!/usr/bin/bash
# Setup:
# Add imports.desktop.nix as ./imports.desktop.nix to imports section of the configuration.nix file in /etc/nixos/
# Usage:
# Run the following command: curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/setup.desktop.bash | bash

cd /etc/nixos

# channel
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/channel.unstable.nix -O

# desktop
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/desktop.kde.nix -O

# hardware
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/hardware.audio.nix -O
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/hardware.radeon.nix -O
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/hardware.bluetooth.nix -O
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/hardware.razer.nix -O

# services
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/services.sunshine.nix -O
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/services.openrgb.nix -O
# other
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/customizations.nix -O

# imports
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/imports.desktop.nix -O

# rebuild
nixos-rebuild --upgrade-all boot
exit
