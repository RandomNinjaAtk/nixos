#!/usr/bin/bash

sudo dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf update -y --refresh
sudo dnf install -y \
  steam-devices \
  openrgb \
  openrgb-udev-rules
  # steam

# gnome
sudo dnf install -y \
  gnome-tweaks \
  gnome-extensions-app \
  gnome-shell-extension-system-monitor-applet \
  gnome-shell-extension-gsconnect \
  gnome-shell-extension-gamemode \
  gnome-shell-extension-dash-to-panel \
  gnome-shell-extension-blur-my-shell \
  gnome-shell-extension-appindicator \
  gnome-shell-extension-netspeed \
  gnome-shell-extension-pop-shell
  
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"

# Multi Media Codecs:
sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
sudo dnf install -y lame\* --exclude=lame-devel
sudo dnf -y group upgrade --with-optional Multimedia

echo "Setting up flatpak"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak -y install flathub \
  com.valvesoftware.Steam \
  com.valvesoftware.SteamLink \
  dev.lizardbyte.app.Sunshine \
  com.discordapp.Discord \
  org.signal.Signal \
  org.videolan.VLC \
  tv.plex.PlexHTPC \
  com.plexamp.Plexamp \
  com.github.iwalton3.jellyfin-media-player \
  org.mozilla.Thunderbird \
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
  org.gnome.Firmware \
  io.missioncenter.MissionCenter \
  com.mattjakeman.ExtensionManager
  #org.gnome.Extensions
  # org.mozilla.firefox \
  # com.valvesoftware.Steam \

# Update flatpaks
flatpak update -y

# Sunshine Permissions
sudo chown $USER /dev/uinput && echo 'KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/85-sunshine-input.rules
sudo flatpak override --talk-name=org.freedesktop.Flatpak dev.lizardbyte.app.Sunshine

echo "Exiting...."
exit
