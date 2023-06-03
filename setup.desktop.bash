#!/usr/bin/bash
# Setup:
# Add imports.desktop.nix as ./imports.desktop.nix to imports section of the configuration.nix file in /etc/nixos/
# Usage:
# Run the following command: curl https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/setup.desktop.bash | bash

cd /etc/nixos

# kernel
echo "Getting Kernel Configurations"
curl -s https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/kernel.nix -O
echo "Done"

# channel
echo "Getting Nix Channel Configurations"
curl -s https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/channel.unstable.nix -O
echo "Done"

# desktop
echo "Getting desktop.kde.nix"
curl -s https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/desktop.kde.nix -O
echo "Done"

# hardware
echo "Getting Hardware configurations"
curl -s https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/hardware.audio.nix -O
curl -s https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/hardware.radeon.nix -O
curl -s https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/hardware.bluetooth.nix -O
curl -s https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/hardware.razer.nix -O
echo "Done"

# networking
echo "Getting Network configurations"
curl -s https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/networking.nix -O
echo "Done"

# printing
echo "Getting Printer configurations"
curl -s https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/enable.printing.nix -O
echo "Done"

# services
echo "Getting Services configurations"
curl -s https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/services.openrgb.nix -O
curl -s https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/services.cockpit.nix -O
echo "Done"

# packages
echo "Getting Desktop Packages configurations"
curl -s https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/packages.desktop.nix -O
echo "Done"

# other
echo "Getting Other configurations"
curl -s https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/customizations.nix -O
echo "Done"

echo "Getting Nix import configuration"
# imports
curl -s https://raw.githubusercontent.com/RandomNinjaAtk/nixos/main/imports.desktop.nix -O
echo "Done"

# rebuild
echo "Performing NixOS garbage collection, older than 5 days..."
nix-collect-garbage --delete-older-than 5d 1> /dev/null
echo "Done"
echo "Performing NixOS Rebuild, Upgrade and Boot..."
nixos-rebuild --upgrade-all boot 1> /dev/null
echo "Done"

echo "Setting up flatpak"
flatpak -y remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak -y install flathub dev.lizardbyte.app.Sunshine -y
flatpak -y override --talk-name=org.freedesktop.Flatpak dev.lizardbyte.app.Sunshine
flatpak -y install flathub com.valvesoftware.Steam
flatpak -y install flathub com.valvesoftware.SteamLink
flatpak -y install flathub com.discordapp.Discord
flatpak -y install flathub org.signal.Signal
flatpak -y install flathub org.gnome.Boxes
flatpak -y install flathub org.videolan.VLC
flatpak -y install flathub org.kde.kwrite
flatpak -y install flathub tv.plex.PlexHTPC
flatpak -y install flathub com.plexamp.Plexamp
flatpak -y install flathub com.github.iwalton3.jellyfin-media-player
flatpak -y install flathub org.mozilla.Thunderbird
flatpak -y install flathub org.mozilla.firefox
flatpak -y install flathub com.github.Eloston.UngoogledChromium
flatpak -y install flathub net.mediaarea.MediaInfo
flatpak -y install flathub com.bitwarden.desktop
flatpak -y install flathub io.otsaloma.nfoview
flatpak -y install flathub xyz.z3ntu.razergenie
flatpak -y install flathub org.kde.kontact
flatpak -y install flathub hu.kramo.Cartridges
# chown $USER /dev/uinput && echo 'KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"' | tee /etc/udev/rules.d/85-sunshine-input.rules

echo "Reboot system for changes to take affect..."
echo "Exiting...."
exit
