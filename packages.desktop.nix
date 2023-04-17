{pkgs, ...}: {

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Remove packages
  services.xserver.excludePackages = [ pkgs.xterm ]; # remove xterm
  
  # programs
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  }; # steam

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
