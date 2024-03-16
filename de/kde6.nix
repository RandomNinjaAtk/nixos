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
  services.desktopManager.plasma6.enable = true;
  services.xserver.displayManager.sddm.wayland.enable = true;
  #services.xserver.displayManager.defaultSession = "plasma";
  services.xserver.displayManager.sddm.autoNumlock = true; # enable numlock

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
    kdePackages.krunner
    kdePackages.kdeplasma-addons # addons
    kdePackages.kaccounts-integration
    kdePackages.kaccounts-providers
    kdePackages.plasma-browser-integration # browser integration (chrome/firefox)
    kdePackages.kmail # mail application
    kdePackages.kontact # contacts application
    kdePackages.discover # app store
    kdePackages.kate # kwrite
    kdePackages.kcalc # calculator
    kdePackages.filelight # disk usage analyzer
    kdePackages.korganizer # calendar/organizer
    kdePackages.akregator # rss feed reader
    kdePackages.kaddressbook # contact addressbook
    kdePackages.kweather # weather app
    kdePackages.neochat # matrix client
    kdePackages.tokodon # mastadon client
    kdePackages.kasts # podcast app
    kdePackages.plasmatube # youtube app
    kdePackages.krfb # Krfb Desktop Sharing (VNC)
    kdePackages.skanlite # scanner application
    kdePackages.ksystemlog # syslog viewer
    kdiskmark # disk speed tester
    kdePackages.yakuake # dropdown console
    isoimagewriter # iso image writer
    kdePackages.signond
    kdePackages.kauth
  ];

  # Remove packages
  services.xserver.excludePackages = [ pkgs.xterm ]; # remove xterm  
}

# Instructions to swtich until KDE6 hits stable release
# Commands:
# sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
# sudo nix-channel --remove unstable
# sudo nix-channel --update
# sudo nixos-rebuild boot --upgrade-all
# sudo reboot
