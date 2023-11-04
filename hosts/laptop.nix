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
      ./services.sunshine.nix
    ];

  nixpkgs.config = {
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };

  # Boot Options
  boot.kernelPackages = pkgs.linuxPackages_latest; # kernel update
  boot.supportedFilesystems = [ "ntfs" ];
  boot.initrd.kernelModules = ["amdgpu"];
  services.xserver.videoDrivers = ["amdgpu"];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # hardware
  hardware.cpu.amd.updateMicrocode = true;
  hardware.bluetooth.enable = true;
  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;

  # desktop environment
  services.xserver.displayManager.sddm.autoNumlock = true; # enable numlock

  # KDE specifics
  programs.partition-manager.enable = true; # kde partitioning tool
  programs.kdeconnect.enable = true; # kde connect services

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
  services.sunshine.enable = true; # enable sunshine custom module

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

  # Packages
  nixpkgs.config.permittedInsecurePackages = [
    "electron-24.8.6"
  ];

  environment.systemPackages = with pkgs; [
    curl
    wget
    htop
    protonup-ng
    bitwarden
    chromium
    firefox
    thunderbird
    plexamp
    plex-media-player
    jellyfin-media-player
    kodi
    element-desktop
    vlc
    nordic # theme
    libreoffice
    # unstable packages
    unstable.rustdesk
    unstable.newsflash
    unstable.mission-center
    unstable.pegasus-frontend
    unstable.attract-mode
    unstable.signal-desktop
    unstable.discord
    unstable.moonlight-qt
    unstable.protonup-qt
    # KDE
    libsForQt5.kdeplasma-addons # addons
    libsForQt5.kaccounts-integration
    libsForQt5.kaccounts-providers
    libsForQt5.kmail # mail application
    libsForQt5.kontact # contacts application
    libsForQt5.discover # app store
    libsForQt5.kate # kwrite
    libsForQt5.kcalc # calculator
    libsForQt5.filelight # disk usage analyzer
    libsForQt5.korganizer # calendar/organizer
    libsForQt5.akregator # rss feed reader
    libsForQt5.kaddressbook # contact addressbook
    libsForQt5.kweather # weather app
    libsForQt5.neochat # matrix client
    libsForQt5.tokodon # mastadon client
    libsForQt5.kasts # podcast app
    libsForQt5.plasmatube # youtube app
    libsForQt5.krfb # Krfb Desktop Sharing (VNC)
    libsForQt5.skanlite # scanner application
    libsForQt5.ksystemlog # syslog viewer
    kdiskmark # disk speed tester
    libsForQt5.yakuake # dropdown console
    isoimagewriter # iso image writer
  ];

  # Remove packages
  services.xserver.excludePackages = [ pkgs.xterm ]; # remove xterm

  # Programs
  programs.gamemode.enable = true;
  programs.dconf.enable = true;
  
  programs.firefox = {                  
    enable = true;
    preferences = {
    "widget.use-xdg-desktop-portal.file-picker" = 1;
    "widget.use-xdg-desktop-portal.mime-handler" = 1;
    };
  };


  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    gamescopeSession.enable = true; # Whether to enable GameScope Session.
  }; # steam

  # Nix garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}
