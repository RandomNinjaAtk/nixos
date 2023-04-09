{pkgs, ...}: {

  # boot changes
  boot.kernelPackages = pkgs.linuxPackages_latest; # kernel update
  
  # hardware enablement
  hardware.bluetooth.enable = true; # enable bluetooth
  
  # networking
  networking.firewall.enable = false;
  
  # services
  services.flatpak.enable = true; # flatpak
  services.hardware.openrgb.enable = true; # openrgb

  # packages
  environment.systemPackages = with pkgs; [
    htop
    wget
    curl
    firefox
    thunderbird
  ];
  
  # programs
  programs.steam.enable = true; # add steam
}
