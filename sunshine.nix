{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.services.sunshine;

in

{
  options = {

    services.sunshine = {
      enable = mkEnableOption (mdDoc "Sunshine");
    };

  };

  config = mkIf config.services.sunshine.enable {

    # Install sunshine
    environment.systemPackages = with pkgs; [ sunshine ];
  
    # Requires to simulate input
    boot.kernelModules = [ "uinput" ];
    services.udev.extraRules = ''
      KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"
    '';

    security.wrappers.sunshine = {
      capabilities = "cap_sys_admin+p";
      source = "${pkgs.sunshine}/bin/sunshine";
    };
    
    systemd.user.services.sunshine = {
      description = "Sunshine self-hosted game stream host for Moonlight.";
      startLimitIntervalSec = 500;
      startLimitBurst = 5;
      wantedBy = [ "graphical-session.target" ];
  
      serviceConfig = {
        Restart = "on-failure";
        RestartSec = "5s";
        ExecStart = "${pkgs.sunshine}/bin/sunshine";
      };
    };
  };
}

# Get Service Status
# systemctl --user restart sunshine
