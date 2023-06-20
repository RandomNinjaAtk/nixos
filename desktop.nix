{ config, pkgs, ... }:

{
  imports =
    [
      ./services.sunshine.nix
    ];
    
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Packages
  environment.systemPackages = with pkgs; [
    curl
    wget
    htop
    signal-desktop
    discord
    rpi-imager
    ungoogled-chromium
    firefox
    thunderbird
    openrgb-with-all-plugins
    razergenie
    moonlight-qt
    vmware-horizon-client
  ];

  hardware.bluetooth.enable = true;
  hardware.openrazer.enable = true;
  services.openssh.enable = true;
  services.hardware.openrgb.enable = true;
  services.sunshine.enable = true;
  services.tailscale.enable = true;
  networking.firewall.enable = false;
  services.avahi.publish.userServices = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
}
