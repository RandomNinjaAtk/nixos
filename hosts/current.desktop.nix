{ config, pkgs, ... }:

{
  imports =
    [
      #./services.sunshine.nix
      #./samba.nix
      ./hardware.radeon.nix
    ];

  # Update to the latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest; # kernel update
  boot.supportedFilesystems = [ "ntfs" ];
  boot.initrd.kernelModules = ["amdgpu"];
  services.xserver.videoDrivers = ["amdgpu"];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # hardware
  hardware.cpu.amd.updateMicrocode = true;
  hardware.cpu.intel.updateMicrocode = true;
  hardware.bluetooth.enable = true;
  hardware.enableRedistributableFirmware = true;

  # networking
  networking.firewall.enable = false;

  # desktop environment
  services.xserver.displayManager.sddm.autoNumlock = true; # enable numlock

  # KDE specifics
  programs.partition-manager.enable = true; # kde partitioning tool
  programs.kdeconnect.enable = true; # kde connect services

  # services
  services.openssh.enable = true; # ssh
  services.hardware.openrgb.enable = true; # openrgb
  services.tailscale.enable = true; # tailscale
  services.fprintd.enable = true; # finger print reader
  services.flatpak.enable = true; # flatpak
  services.fwupd.enable = true; # firmware updates
  services.locate.enable = true; # enable locate services
  services.packagekit.enable = true; # enable packagekit for discover app
  
  # Power
  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      CPU_BOOST_ON_BAT = 0;
      CPU_SCALING_GOVERNOR_ON_BATTERY = "powersave";
      START_CHARGE_THRESH_BAT0 = 90;
      STOP_CHARGE_THRESH_BAT0 = 97;
      RUNTIME_PM_ON_BAT = "auto";
    };
  };

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
  environment.systemPackages = with pkgs; [
    curl
    wget
    htop
    clinfo
    glxinfo
    vulkan-tools
    bitwarden
    signal-desktop
    discord
    rpi-imager
    chromium
    firefox
    thunderbird
    openrgb-with-all-plugins
    moonlight-qt
    plexamp
    plex-media-player
    jellyfin-media-player
    kodi
    element-desktop
    vlc
    rustdesk
    # KDE
    nordic # theme
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

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    gamescopeSession.enable = true; # Whether to enable GameScope Session.
  }; # steam
}
