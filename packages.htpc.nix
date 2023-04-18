{pkgs, ...}: {

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Remove packages
  services.xserver.excludePackages = [ pkgs.xterm ]; # remove xterm

  programs.steam = {
    enable = true;
    #remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    #dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  }; # steam

  # packages
  environment.systemPackages = with pkgs; [
    mlocate
    wget
    curl
    firefox
    nextcloud-client
    gping
    wayvnc
    appimage-run
    vlc
    plex-media-player
  ];
}
