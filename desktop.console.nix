{pkgs, ...}: {

  
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  
  # Enable the GNOME Desktop Environment  
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.autoLogin.user = "gamer";
  services.xserver.desktopManager.gnome.enable = true;
  
  # packages
  environment.systemPackages = with pkgs; [
    # gamescope
  ];

}
