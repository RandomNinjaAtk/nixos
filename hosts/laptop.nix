{ config, pkgs, ... }:

{
  imports =
    [
      #./services.sunshine.nix
      #./samba.nix
    ];

  # Update to the latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest; # kernel update
  boot.supportedFilesystems = [ "ntfs" ];
  boot.initrd.kernelModules = ["amdgpu"];
  services.xserver.videoDrivers = ["amdgpu"];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # hardware
  hardware.cpu.intel.updateMicrocode = true;
  hardware.cpu.amd.updateMicrocode = true;
  hardware.bluetooth.enable = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.enableRedistributableFirmware = true;

  # Power Management
  powerManagement.powertop.enable = true;
  services.power-profiles-daemon.enable = true;

  # networking
  networking.firewall.enable = false;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
 
  # desktop environment
  services.xserver.displayManager.defaultSession = "plasma"; # plasma or plasmawayland or plasma-bigscreen-wayland or steam
  services.xserver.displayManager.sddm.autoNumlock = true; # enable numlock
  services.xserver.displayManager.sddm.enableHidpi = true; # enable automatic HiDPI mode

  # KDE specifics
  programs.partition-manager.enable = true; # kde partitioning tool
  programs.kdeconnect.enable = true; # kde connect services  

  # services
  services.openssh.enable = true; # ssh
  services.hardware.openrgb.enable = true; # openrgb
  #services.sunshine.enable = true; # custom sunshine module
  services.tailscale.enable = true; # tailscale
  services.fprintd.enable = true; # finger print reader
  services.flatpak.enable = true; # flatpak
  services.fwupd.enable = true; # firmware updates
  services.locate.enable = true; # enable locate services
  services.packagekit.enable = true; # enable packagekit for discover app

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
  
  # Programs
  programs.gamescope.enable = true; # install gamescope
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    gamescopeSession.enable = true; # Whether to enable GameScope Session.
  }; # steam
}
