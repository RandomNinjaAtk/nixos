{ config, pkgs, ... }: {
  imports = [
     ./services.sunshine.nix
     #./samba.nix
  ];

  # boot options/configurations
  boot.supportedFilesystems = [ "ntfs" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # gnome
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  # hardware
  hardware.bluetooth.enable = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.steam-hardware.enable = true;
  hardware.xone.enable = true;
  hardware.xpadneo.enable = true;

  # networking
  networking.firewall.enable = false;

  # services
  services.openssh.enable = true; # ssh
  services.hardware.openrgb.enable = true; # openrgb
  services.sunshine.enable = true; # custom sunshine module
  services.tailscale.enable = true; # tailscale
  services.fprintd.enable = true; # finger print reader
  services.flatpak.enable = true; # flatpak
  services.fwupd.enable = true; # firmware updates

  # Print Services
  services.printing.enable = true; # enable printing
  services.printing.drivers = [ 
    pkgs.cnijfilter2 # G6000 Series Print Driver
  ];

  # Avahi
  services.avahi = {
    enable = true;
    reflector = true;
    nssmdns = true;
    openFirewall = true;
    publish = {
      enable = true;
      addresses = true;
      userServices = true;
      workstation = true;
    };
  };
  
  # Remove packages
  services.xserver.excludePackages = [ pkgs.xterm ]; # remove xterm

  # Packages
  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-panel
    gnomeExtensions.arcmenu
  ];      
}
