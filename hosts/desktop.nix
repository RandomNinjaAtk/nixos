{ config, pkgs, ... }:

{
  imports =
    [
      ./services.sunshine.nix
    ];

  # Update to the latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest; # kernel update
    
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # hardware
  hardware.bluetooth.enable = true;
  hardware.openrazer.enable = true;

  # networking
  networking.firewall.enable = false;
  
  # desktop environment
  # Enable Wayland Default
  services.xserver.displayManager.defaultSession = "plasmawayland"; # plasma or plasmawayland or plasma-bigscreen-wayland
  services.xserver.displayManager.sddm.autoNumlock = true; # enable numlock 

  # services
  services.openssh.enable = true;
  services.hardware.openrgb.enable = true;
  services.sunshine.enable = true;
  services.tailscale.enable = true;

  # Avahi
  services.avahi = {
    enable = true;
    reflector = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
      userServices = true;
      workstation = true;
    };
  };

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

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
}
