{ config, pkgs, ... }:

let
  # We point directly to 'gnugrep' instead of 'grep'
  grep = pkgs.gnugrep;

  # 1. Declare the Flatpaks you *want* on your system
  desiredFlatpaks = [
    #"io.missioncenter.MissionCenter"
    "io.gitlab.adhami3310.Impression"
    #"com.github.iwalton3.je"
    "io.gitlab.news_flash.NewsFlash"
    "net.codelogistics.webapps"
    # Utilities
    #"com.kgurgul.cpuinfo"
    "org.gnome.Firmware"
    #"com.rustdesk.RustDesk"
    "com.bitwarden.desktop"
    # Productivity
    #"org.kde.kate"
    #"org.kde.kwrite"
    #"org.mozilla.firefox"
    #"org.mozilla.Thunderbird"
    "org.libreoffice.LibreOffice"
    "com.vscodium.codium"
    "com.brave.Browser"
    # Media
    "com.github.KRTirtho.Spotube"
    "com.github.iwalton3.jellyfin-media-player"
    "com.unicornsonlsd.finamp"
    "tv.plex.PlexHTPC"
    "tv.plex.PlexDesktop"
    "tv.kodi.Kodi"
    # Social
    "org.telegram.desktop"
    "com.discordapp.Discord"
    # Gaming
    "page.kramo.Cartridges"
    "io.github.hmlendea.geforcenow-electron"
    "com.heroicgameslauncher.hgl"
    "com.moonlight_stream.Moonlight"
    "org.libretro.RetroArch"
    "com.valvesoftware.SteamLink"
    "net.lutris.Lutris"
    "net.studio08.xbplay" # xbox remote play
    "net.davidotek.pupgui2" # ProtonUp-QT
  ];
in
{
  services.flatpak.enable = true;
  system.activationScripts.flatpakManagement = {
    text = ''
      # 2. Ensure the Flathub repo is added
      ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub \
        https://flathub.org/repo/flathub.flatpakrepo

      # 3. Get currently installed Flatpaks
      installedFlatpaks=$(${pkgs.flatpak}/bin/flatpak list --app --columns=application)

      # 4. Remove any Flatpaks that are NOT in the desired list
      for installed in $installedFlatpaks; do
        if ! echo ${toString desiredFlatpaks} | ${grep}/bin/grep -q $installed; then
          echo "Removing $installed because it's not in the desiredFlatpaks list."
          ${pkgs.flatpak}/bin/flatpak uninstall -y --noninteractive $installed
        fi
      done

      # 5. Install or re-install the Flatpaks you DO want
      for app in ${toString desiredFlatpaks}; do
        echo "Ensuring $app is installed."
        ${pkgs.flatpak}/bin/flatpak install -y flathub $app
      done

      # 6. Update all installed Flatpaks
      ${pkgs.flatpak}/bin/flatpak update -y
    '';
  };
}
