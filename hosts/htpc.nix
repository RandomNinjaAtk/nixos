{ config, pkgs, ... }: {
  imports = [
     ./services.sunshine.nix
     ./services.steam.nix
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

  # Enable AutoLogin
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "user";
  systemd.services."getty@tty1".enable = false; # autologin workaround (https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229)
  systemd.services."autovt@tty1".enable = false; # autologin workaround (https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229)

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
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
    cheese # webcam tool
    gnome-music
    geary # email reader
    evince # document viewer
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
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

  # networking
  networking.firewall.enable = false;

  # services
  services.openssh.enable = true; # ssh
  services.hardware.openrgb.enable = true; # openrgb
  services.sunshine.enable = true; # custom sunshine module
  services.flatpak.enable = true; # flatpak
  services.fwupd.enable = true; # firmware updates

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
    # THEMES
    dracula-theme
    dracula-icon-theme
    gnome.adwaita-icon-theme
    # PACKAGES
    openrgb-with-all-plugins
    firefox
    moonlight-qt
    plex-media-player
    jellyfin-media-player
    kodi
  ];

  # STEAM 
  #programs.steam.gamescopeSession.enable = false; # Whether to enable GameScope Session.
  #programs.steam.gamescopeSession = true; # Run a GameScope driven Steam session from your display-manager
}
