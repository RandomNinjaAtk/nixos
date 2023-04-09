{pkgs, ...}: {

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
    
  # packages
  environment.systemPackages = with pkgs; [
    gnomeExtensions.dash-to-panel
    gnome-randr
  ];

}
