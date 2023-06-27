{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.services.sunshine;
  unstable = import (fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz) {config.allowUnfree = true;};
in

{
  options = {

    services.sunshine = {
      enable = mkEnableOption (mdDoc "Sunshine");
    };

  };

  config = mkIf config.services.sunshine.enable {

    environment.systemPackages = with pkgs; [ unstable.sunshine ];

    security.wrappers.sunshine = {
      owner = "root";
      group = "root";
      capabilities = "cap_sys_admin+p";
      source = "${pkgs.sunshine}/bin/sunshine";
    };

    # Requires to simulate input
    boot.kernelModules = [ "uinput" ];
    services.udev.extraRules = ''
      KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"
    '';

    systemd.user.services.sunshine =
      {
        description = "sunshine";
        wantedBy = [ "graphical-session.target" ];
        serviceConfig = {
          ExecStart = "${config.security.wrapperDir}/sunshine";
        };
      };

  };
}

# Enable using:
# services.sunshine.enable = true;
# Get Service Status
# systemctl --user status sunshine
# get logs
# journalctl --user -u sunshine --since "2 minutes ago"
