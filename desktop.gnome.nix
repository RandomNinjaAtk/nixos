{pkgs, ...}: {

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
    
  # package exclusions
  environment.gnome.excludePackages = with pkgs; [
    gnome-console
  ];
  
  # package additions
  environment.systemPackages = with pkgs; [
    gnome.gnome-terminal
    gnomeExtensions.dash-to-panel
    gnomeExtensions.tiling-assistant
    gnome-randr # Resolution Changer
    remmina # RDP Client
    gnome-firmware
  ];

}

# Notes

# Resolution Change Exmaple for Sunshine:
# gnome-randr modify DP-4 --mode 1920x1080@120.000 # Change to 1080p
