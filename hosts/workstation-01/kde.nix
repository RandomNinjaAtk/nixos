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

  # KDE6
  services.xserver.enable = true; # enable x11
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "plasma"; # plasmax11 for x11, plasma for wayland

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    #plasma-browser-integration
    #konsole
  ];

  environment.systemPackages = with pkgs.kdePackages; [
    konsole
    plasma-browser-integration
  ];
  
}
