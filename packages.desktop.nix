{pkgs, ...}: {

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Remove packages
  services.xserver.excludePackages = [ pkgs.xterm ]; # remove xterm

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
    wayvnc
    rpi-imager
    appimage-run
    vmware-horizon-client
    vlc
  ];
}