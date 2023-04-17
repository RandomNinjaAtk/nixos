{pkgs, ...}: {
  
  # hardware enablement
  hardware.uinput.enable = true; # enable uinput
  hardware.steam-hardware.enable = true; # steam hardware
      
  services.fprintd.enable = true; # finger print reader
  services.flatpak.enable = true; # flatpak
  services.fwupd.enable = true; # firmware updates
  

  # other
  xdg.portal.wlr.enable = true; # wayland compositor for screensharing
}
