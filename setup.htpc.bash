#!/usr/bin/bash
# Setup:
# Add imports.desktop.nix as ./imports.htpc.nix to imports section of the configuration.nix file in /etc/nixos/
# Usage:
# Run the following command: curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/setup.htpc.bash | bash

# channel
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/channel.unstable.nix -O /etc/nixos/

# desktop
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/desktop.kde.nix -O /etc/nixos/

# hardware
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/hardware.audio.nix -O /etc/nixos/
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/hardware.radeon.nix -O /etc/nixos/
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/hardware.bluetooth.nix -O /etc/nixos/

# services
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/services.sunshine.nix -O /etc/nixos/
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/services.steam.nix -O /etc/nixos/

# imports
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/imports.htpc.nix -O /etc/nixos/

# rebuild
nixos-rebuild --upgrade-all boot
exit
