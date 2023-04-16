#!/usr/bin/bash
# Setup:
# Add imports.desktop.nix as ./imports.desktop.nix to imports section of the configuration.nix file in /etc/nixos/
# Usage:
# Run the following command: curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/setup.desktop.bash | bash

# channel
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/channel.unstable.nix -O /etc/nixos/

# desktop
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/desktop.kde.nix -O /etc/nixos/

# hardware
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/hardware.audio.nix -O /etc/nixos/
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/hardware.radeon.nix -O /etc/nixos/
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/hardware.bluetooth.nix -O /etc/nixos/
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/hardware.razer.nix -O /etc/nixos/

# services
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/services.sunshine.nix -O /etc/nixos/

# other
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/customizations.nix -O /etc/nixos/

# imports
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/imports.desktop.nix -O /etc/nixos/

# rebuild
nixos-rebuild --upgrade-all boot
exit
