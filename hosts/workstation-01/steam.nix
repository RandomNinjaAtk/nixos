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
  
  environment.systemPackages = with pkgs; [
    unstable.steam-devices-udev-rules # steam udev rules for controllers
    #unstable.game-devices-udev-rules # udev rules for controllers
  ];
  
  # steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers.
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    protontricks.enable = true; # Whether to enable protontricks, a simple wrapper for running Winetricks commands for Proton-enabled games.
  };
 
  hardware.uinput.enable = true;

  #systemd.user.services.steam = {
  #  enable = true;
  #  description = "Open Steam in the background at boot";
  #  wants = [ "network-online.target" ];
  #  after = [ "network-online.target" ];
    #wants = [ "graphical-session.target" ];
    #partOf = [ "graphical-session.target" ];
    #after = [ "graphical-session.target" ];
  #  startLimitBurst = 5;
  #  wantedBy = ["default.target"];
  #  startLimitIntervalSec = 500;
  #  serviceConfig = {
  #    ExecStart = "${pkgs.steam}/bin/steam -nochatui -nofriendsui -silent %U";
  #    Restart = "on-failure";
  #    RestartSec = "5s";
  #  };
  #};
}
