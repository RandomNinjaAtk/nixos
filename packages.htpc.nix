{pkgs, ...}: {

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Remove packages
  services.xserver.excludePackages = [ pkgs.xterm ]; # remove xterm

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
