{ config, pkgs, ... }:
let
  unstableTarball =
    fetchTarball
      https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;  
in
{

  imports =
    [ # Include the results of the hardware scan.
     # /etc/nixos/hardware-configuration.nix
    ];

  nixpkgs.config = {
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };


  # Boot Options
  boot.supportedFilesystems = [ "ntfs" ];
  boot.initrd.kernelModules = ["amdgpu"];
  services.xserver.videoDrivers = ["amdgpu"];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # hardware
  hardware.cpu.amd.updateMicrocode = true;
  hardware.cpu.intel.updateMicrocode = true;
  hardware.bluetooth.enable = true;
  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;

  # networking
  networking.firewall.enable = false;

  # services
  services.openssh.enable = true; # ssh
  services.hardware.openrgb.enable = true; # openrgb
  services.tailscale.enable = true; # tailscale
  services.fprintd.enable = true; # finger print reader
  services.flatpak.enable = true; # flatpak
  services.fwupd.enable = true; # firmware updates
  services.locate.enable = true; # enable locate services

  # Print Services
  services.printing.enable = true; # enable printing
  services.printing.drivers = [ 
    pkgs.cnijfilter2 # G6000 Series Print Driver
  ];

  # Avahi
  services.avahi = {
    enable = true;
    reflector = true;
    nssmdns = true;
    openFirewall = true;
    publish = {
      enable = true;
      addresses = true;
      userServices = true;
      workstation = true;
    };
  };

  # gnome
  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.desktop.wm.preferences]
    button-layout=':minimize,maximize,close'
    resize-with-right-button=true

    [org.gnome.SessionManager]
    auto-save-session=true

    [org.gtk.Settings.FileChooser]
    sort-directories-first=true
  '';

  # Packages
  environment.systemPackages = with pkgs; [
    curl
    wget
    htop
    bitwarden
    rpi-imager
    chromium
    firefox
    thunderbird
    openrgb-with-all-plugins
    plexamp
    plex-media-player
    jellyfin-media-player
    kodi
    element-desktop
    vlc
    nordic # theme
    libreofficev
    # unstable packages
    unstable.sunshine
    unstable.rustdesk
    unstable.newsflash
    unstable.mission-center
    unstable.pegasus-frontend
    unstable.attract-mode
    unstable.signal-desktop
    unstable.discord
    unstable.moonlight-qt
    unstable.protonup-qt
    #### GNOME
    gnome.gnome-tweaks
    # EXTENSIONS
    gnomeExtensions.gsconnect
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.caffeine
    gnomeExtensions.blur-my-shell
    gnomeExtensions.vitals
    gnomeExtensions.gamemode
    gnomeExtensions.alphabetical-app-grid
    gnomeExtensions.dash-to-panel
    gnomeExtensions.arcmenu
    gnomeExtensions.wireless-hid
    gnomeExtensions.simple-system-monitor
    gnomeExtensions.tiling-assistant
    gnomeExtensions.no-overview
  ];

  # Remove packages
  services.xserver.excludePackages = [ pkgs.xterm ]; # remove xterm

  # Programs
  programs.gamemode.enable = true;

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    gamescopeSession.enable = true; # Whether to enable GameScope Session.
  }; # steam
}
