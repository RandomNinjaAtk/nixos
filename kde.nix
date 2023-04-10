{pkgs, ...}: {

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # packages
  environment.systemPackages = with pkgs; [
    kate
  ];
}

# Notes

# Resolution Change Exmaple:
# xrandr --output DP-4 --mode 1920x1080 # Change to 1080p
