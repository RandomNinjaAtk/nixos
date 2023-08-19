{ config, pkgs, ... }: {
  imports = [
     ./services.sunshine.nix
     #./samba.nix
  ];

  # set internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  # boot options/configurations
  boot.kernelPackages = pkgs.linuxPackages_latest; # kernel update
  boot.supportedFilesystems = [ "ntfs" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # session
  services.xserver.displayManager.defaultSession = "gnome"; # default sessoin (gnome or steam)

  # gnome
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  services.gnome.gnome-remote-desktop.enable = true;
  services.xserver.displayManager.gdm.wayland = true; # Allow GDM to run on Wayland instead of Xserver
  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.desktop.interface]
    gtk-theme='Dracula'

    [org.gnome.desktop.wm.preferences]
    button-layout=':minimize,maximize,close'
    resize-with-right-button=true
    theme='Dracula'

    [org.gnome.desktop.interface.icon-theme]
    theme='Dracula'

    [org.gnome.SessionManager]
    auto-save-session=true

    [org.gtk.Settings.FileChooser]
    sort-directories-first=true
  '';

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    gnome-terminal
    gedit # text editor
    epiphany # web browser
    gnome-characters
  ]);

  # hardware
  hardware.bluetooth.enable = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.openrazer.enable = true;

  # networking
  networking.firewall.enable = false;

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

  # programs
  programs.gamemode.enable = true; # for steam
  programs.dconf.enable = true;
  
  # Remove packages
  services.xserver.excludePackages = [ pkgs.xterm ]; # remove xterm

  # Packages
  environment.systemPackages = with pkgs; [
    # EXTENSIONS
    gnome.gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-panel
    gnomeExtensions.arcmenu
    gnomeExtensions.wireless-hid
    gnomeExtensions.simple-system-monitor
    gnomeExtensions.tiling-assistant
    gnomeExtensions.no-overview
    # THEMES
    dracula-theme
    dracula-icon-theme
    nordic
    gnome.adwaita-icon-theme
    beauty-line-icon-theme
    # PACKAGES
    openrgb-with-all-plugins
    gamescope
    mangohud
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    gamescopeSession.enable = false; # Whether to enable GameScope Session.
  };

}
