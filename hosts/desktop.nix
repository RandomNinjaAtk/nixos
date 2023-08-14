{ config, pkgs, ... }:

{
  imports =
    [
      ./services.sunshine.nix
      ./samba.nix
    ];

  # Update to the latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest; # kernel update
  boot.supportedFilesystems = [ "ntfs" ];
    
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # hardware
  hardware.bluetooth.enable = true;
  hardware.openrazer.enable = true;

  # networking
  networking.firewall.enable = false;
  
  # desktop environment
  # Enable Wayland Default
  services.xserver.displayManager.defaultSession = "plasmawayland"; # plasma or plasmawayland or plasma-bigscreen-wayland
  services.xserver.displayManager.sddm.autoNumlock = true; # enable numlock

  # KDE specifics
  programs.partition-manager.enable = true; # kde partitioning tool

  # services
  services.openssh.enable = true; # ssh
  services.hardware.openrgb.enable = true; # openrgb
  services.sunshine.enable = true; # custom sunshine module
  services.tailscale.enable = true; # tailscale
  services.fprintd.enable = true; # finger print reader
  services.flatpak.enable = true; # flatpak
  services.fwupd.enable = true; # firmware updates

  # Print Services
  services.printing.enable = true; # enable printing
  services.printing.drivers = [ 
    pkgs.cnijfilter2 # G6000 Series Print Driver
  ];


  # Remote services
  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "startplasma-x11";
  services.xrdp.openFirewall = true;

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
  environment.systemPackages = with pkgs; [
    curl
    wget
    htop
    signal-desktop
    discord
    rpi-imager
    chromium
    firefox
    thunderbird
    openrgb-with-all-plugins
    razergenie
    moonlight-qt
    vmware-horizon-client
    libsForQt5.kontact
    libsForQt5.discover
    plexamp
    plex-media-player
    jellyfin-media-player
    kodi-wayland
    element-desktop
    vlc
    rustdesk
    kdiskmark
    gnome.gnome-boxes
    distrobox
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
}
