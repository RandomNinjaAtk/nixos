{ config, pkgs, ... }:
let
  cfg = config.services.openrgb;
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
  # Enable openrgb
  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
  };
  systemd.user.services.openrgb =
    {
      description = "openrgbstart";
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.openrgb-with-all-plugins}/bin/openrgb --startminimized";
      };
    };
}

# Enable using:
# services.openrgb.enable = true;
# Get Service Status
# systemctl --user status openrgb
# get logs
# journalctl --user -u openrgb --since "2 minutes ago"
