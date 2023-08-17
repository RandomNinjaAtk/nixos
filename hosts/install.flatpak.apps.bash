#!/usr/bin/bash

echo "Setting up flatpak"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak -y install flathub \
  com.valvesoftware.Steam \
  com.valvesoftware.SteamLink \
  com.valvesoftware.Steam.CompatibilityTool.Boxtron \
  com.github.Matoking.protontricks \
  org.freedesktop.Platform.VulkanLayer.vkBasalt/x86_64/stable \
  com.valvesoftware.Steam.Utility.gamescope \
  com.discordapp.Discord \
  org.signal.Signal \
  org.videolan.VLC \
  tv.plex.PlexHTPC \
  com.plexamp.Plexamp \
  com.github.iwalton3.jellyfin-media-player \
  org.mozilla.Thunderbird \
  org.mozilla.firefox \
  com.github.Eloston.UngoogledChromium \
  net.mediaarea.MediaInfo \
  com.bitwarden.desktop \
  io.otsaloma.nfoview \
  hu.kramo.Cartridges \
  org.raspberrypi.rpi-imager \
  com.nextcloud.desktopclient.nextcloud \
  com.moonlight_stream.Moonlight \
  com.heroicgameslauncher.hgl \
  com.github.tchx84.Flatseal \
  com.usebottles.bottles \
  org.musicbrainz.Picard \
  org.gnome.Firmware

# Update flatpaks
flatpak update -y

echo "Exiting...."
exit
=
