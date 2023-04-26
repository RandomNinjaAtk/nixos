#!/usr/bin/bash
# Setup:
# Add imports.desktop.nix as ./imports.desktop.nix to imports section of the configuration.nix file in /etc/nixos/
# Usage:
# Run the following command: curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/setup.desktop.bash | bash

cd /etc/nixos

# kernel
echo "Getting Kernel Configurations"
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/kernel.nix -O

# channel
echo "Getting Nix Channel Configurations"
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/channel.unstable.nix -O

# desktop
echo "Getting desktop.kde.nix"
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/desktop.kde.nix -O

# hardware
echo "Getting Hardware configurations"
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/hardware.audio.nix -O
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/hardware.radeon.nix -O
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/hardware.bluetooth.nix -O
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/hardware.razer.nix -O

# networking
echo "Getting Network configurations"
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/networking.nix -O

# printing
echo "Getting Printer configurations"
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/enable.printing.nix -O

# services
echo "Getting Services configurations"
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/services.sunshine.nix -O
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/services.openrgb.nix -O

# packages
echo "Getting Desktop Packages configurations"
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/packages.desktop.nix -O

# other
echo "Getting Other configurations"
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/customizations.nix -O

echo "Getting Nix import configuration"
# imports
curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/imports.desktop.nix -O

# rebuild
nixos-rebuild --upgrade-all boot
exit
