{pkgs, ...}: {

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Remove packages
  services.xserver.excludePackages = [ pkgs.xterm ]; # remove xterm
  
  # programs
  
  # hardware
  hardware.steam-hardware.enable = true;

  # packages
  environment.systemPackages = with pkgs; [
    mlocate
    htop
    wget
    curl
    gping
    wayvnc
    appimage-run
    vmware-horizon-client
    rustdesk
  ];
}
