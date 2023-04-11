{pkgs, ...}: {

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
    
  # packages
  environment.systemPackages = with pkgs; [
    gnomeExtensions.dash-to-panel
    gnomeExtensions.tiling-assistant
    gnome-randr
  ];

}

# Notes

# Resolution Change Exmaple for Sunshine:
# gnome-randr modify DP-4 --mode 1920x1080@120.000 # Change to 1080p
