{pkgs, ...}: {

  # boot changes
  boot.kernelPackages = pkgs.linuxPackages_latest; # kernel update
    
  # hardware enablement
  hardware.uinput.enable = true; # enable uinput
  hardware.steam-hardware.enable = true; # steam hardware
      
  services.fprintd.enable = true; # finger print reader
  services.flatpak.enable = true; # flatpak
  services.fwupd.enable = true; # firmware updates
  


  
  # programs
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  }; # steam
  
  # other
  xdg.portal.wlr.enable = true; # wayland compositor for screensharing
}
