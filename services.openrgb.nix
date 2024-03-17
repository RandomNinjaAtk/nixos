{ config, lib,  pkgs, ... }:
with lib;
let
  cfg = config.services.openrgb;
in
{
    
  options = {
    services.openrgb = {
      enable = mkEnableOption (mdDoc "OpenRGB");
    };
  };
  config = mkIf config.services.openrgb.enable {
    # Enable openrgb
    services.hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb-with-all-plugins;
    };
    systemd.user.services.openrgb = {
      description = "openrgbstart";
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.openrgb-with-all-plugins}/bin/openrgb --startminimized";
      };
    };
  };
}

# Enable using:
# services.openrgb.enable = true;
# Get Service Status
# systemctl --user status openrgb
# get logs
# journalctl --user -u openrgb --since "2 minutes ago"
