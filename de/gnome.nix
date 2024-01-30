{ config, pkgs, ... }:
let
  unstableTarball =
    fetchTarball
      https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;  
in
{
  nixpkgs.config = {
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # gnome
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  services.gnome.gnome-remote-desktop.enable = true;
  services.xserver.displayManager.gdm.wayland = true; # Allow GDM to run on Wayland instead of Xserver
  services.xserver.desktopManager.gnome.extraGSettingsOverridePackages = [ pkgs.gnome.mutter ];
  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.mutter]
    experimental-features=['scale-monitor-framebuffer']

    [org.gnome.desktop.interface]
    clock-show-seconds=true
    enable-animations=true
    gtk-theme='Adwaita'
    icon-theme='Adwaita'
    color-scheme='prefer-dark'
    clock-format='12h'

    [org.gnome.desktop.wm.preferences]
    button-layout=':minimize,maximize,close'
    resize-with-right-button=true

    [org.gnome.desktop.interface.icon-theme]
    theme='Adwaita'

    [org.gnome.SessionManager]
    auto-save-session=true

    [org.gtk.Settings.FileChooser]
    sort-directories-first=true
  '';

  # https://github.com/rhoriguchi/nixos-setup/blob/master/modules/profiles/gnome.nix
  environment.gnome.excludePackages = [
      pkgs.gnome-tour
      pkgs.gnome.geary
    ];

  # Remove packages
  services.xserver.excludePackages = [ pkgs.xterm ]; # remove xterm

  # Packages
  environment.systemPackages = with pkgs; [
    # EXTENSIONS
    gnome.gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.alphabetical-app-grid
    gnomeExtensions.dash-to-panel
    gnomeExtensions.arcmenu
    gnomeExtensions.wireless-hid
    gnomeExtensions.simple-system-monitor
    gnomeExtensions.tiling-assistant
    gnomeExtensions.no-overview
    # GNOME APPS
    gnome.gnome-tweaks
    gnome-firmware
    gnome-console
    gnome.gnome-boxes
    gnome-photos
    gnome-usage
    # THEMES
    gnome.adwaita-icon-theme
  ];
}
