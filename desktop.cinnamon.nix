{pkgs, ...}: {
  
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  
  # Enable the Cinnamon Desktop Environment  
  services.xserver.desktopManager.cinnamon.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
}
