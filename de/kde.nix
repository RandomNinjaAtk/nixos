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

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.defaultSession = "plasmawayland";
  services.xserver.displayManager.sddm.autoNumlock = true; # enable numlock
  services.xserver.desktopManager.plasma5.bigscreen.enable = false; # allow use of bigscreen

  # Default applications
  xdg.mime.defaultApplications = {
    "text/html" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "x-scheme-handler/about" = "firefox.desktop";
    "x-scheme-handler/unknown" = "firefox.desktop";
    "application/pdf" = "firefox.desktop";
  };

  # Programs
  programs.partition-manager.enable = true; # kde partitioning tool
  programs.kdeconnect.enable = true; # kde connect services

  # Packages
  environment.systemPackages = with pkgs; [
    libsForQt5.krunner
    libsForQt5.kdeplasma-addons # addons
    libsForQt5.kaccounts-integration
    libsForQt5.kaccounts-providers
    libsForQt5.plasma-browser-integration # browser integration (chrome/firefox)
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
    libsForQt5.booth # camera app
    libsForQt5.signond
    libsForQt5.qoauth
  ];

  # Remove packages
  services.xserver.excludePackages = [ pkgs.xterm ]; # remove xterm  
}
