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
  hardware.steam-hardware.enable = true;

  # networking
  networking.firewall.enable = false;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  
  # desktop environment
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.defaultSession = "plasmawayland"; # plasma or plasmawayland or plasma-bigscreen-wayland or steam
  services.xserver.desktopManager.plasma5.bigscreen.enable = true;
  services.xserver.displayManager.sddm.autoNumlock = true; # enable numlock
  services.xserver.displayManager.sddm.enableHidpi = true; # enable automatic HiDPI mode

  # KDE specifics
  programs.partition-manager.enable = true; # kde partitioning tool
  programs.kdeconnect.enable = true; # kde connect services

  # services
  services.openssh.enable = true; # ssh
  services.hardware.openrgb.enable = true; # openrgb
  services.sunshine.enable = true; # custom sunshine module
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

  # Packages
  environment.systemPackages = with pkgs; [
    curl
    wget
    htop
    packagekit
    signal-desktop
    discord
    rpi-imager
    chromium
    firefox
    thunderbird
    openrgb-with-all-plugins
    moonlight-qt
    vmware-horizon-client
    plexamp
    plex-media-player
    jellyfin-media-player
    kodi
    element-desktop
    vlc
    rustdesk
    distrobox
    # KDE
    plasma-overdose-kde-theme # theme
    materia-kde-theme # theme
    graphite-kde-theme # theme
    arc-kde-theme # theme
    nordic # theme
    libsForQt5.packagekit-qt
    libsForQt5.kdeplasma-addons # addons
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

  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
      # For Nixos version > 22.11
      #defaultNetwork.settings = {
      #  dns_enabled = true;
      #};
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
