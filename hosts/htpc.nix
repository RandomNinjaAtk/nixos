{pkgs, ...}: {

  imports =
    [
      ./services.sunshine.nix
      ./services.steam.nix
    ];
  
  # Update to the latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest; # kernel update
    
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # auto update and change to unstable
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  system.autoUpgrade.channel = "https://nixos.org/channels/nixos-unstable/";
    
  # desktop environment
  # Enable Wayland Default
  services.xserver.displayManager.defaultSession = "plasma"; #plasmawayland or plasma-bigscreen-wayland
  services.xserver.displayManager.sddm.autoNumlock = true; # enable numlock 

  # Enable AutoLogin
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "user";
  systemd.services."getty@tty1".enable = false; # autologin workaround (https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229)
  systemd.services."autovt@tty1".enable = false; # autologin workaround (https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229)
    
  # hardware
  hardware.bluetooth.enable = true;
  hardware.openrazer.enable = true;
  
  # networking
  networking.firewall.enable = false;
  
  # services
  services.openssh.enable = true;
  services.sunshine.enable = true;
  
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
    ungoogled-chromium
    firefox
    openrgb-with-all-plugins
    razergenie
    moonlight-qt
    plex-media-player
    jellyfin-media-player
    kodi
  ]; 
}
