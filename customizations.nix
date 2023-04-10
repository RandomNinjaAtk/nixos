{pkgs, ...}: {

  # boot changes
  boot.kernelPackages = pkgs.linuxPackages_latest; # kernel update
  
  # hardware enablement
  hardware.bluetooth.enable = true; # enable bluetooth
  hardware.uinput.enable = true; # enable uinput
  
  # networking
  networking.firewall.enable = false;
  
  # services
  services.flatpak.enable = true; # flatpak
  services.hardware.openrgb.enable = true; # openrgb
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # packages
  environment.systemPackages = with pkgs; [
    mlocate
    vscode
    htop
    wget
    curl
    firefox
    thunderbird
    discord
    signal-desktop
    nextcloud-client
    gping
  ];
  
  # programs
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  }; # stean
}
