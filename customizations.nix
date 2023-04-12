{pkgs, ...}: {

  # boot changes
  boot.kernelPackages = pkgs.linuxPackages_latest; # kernel update
  
  # hardware enablement
  hardware.bluetooth.enable = true; # enable bluetooth
  hardware.uinput.enable = true; # enable uinput
  hardware.opengl.enable = true; # enable opengl support
  hardware.opengl.driSupport = true; # enable accelerated OpenGL rendering 
  hardware.steam-hardware.enable = true; # steam hardware
    
  # networking
  networking.firewall.enable = false;
  
  # services
  services.openssh.enable = true; # ssh server
  services.fprintd.enable = true; # finger print reader
  services.flatpak.enable = true; # flatpak
  services.hardware.openrgb.enable = true; # openrgb
  services.fwupd.enable = true; # firmware updates
  services.xserver.excludePackages = [ pkgs.xterm ]; # remove xterm
  
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
    wayvnc
    rpi-imager
    appimage-run
  ];
  
  # programs
  programs.sway.enable = true; # wayland support
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  }; # steam
  
  # other
  xdg.portal.wlr.enable = true; # wayland compositor for screensharing
}
