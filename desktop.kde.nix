{pkgs, ...}: {

  
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  
  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.defaultSession = "plasmawayland";

  # Programs 
  programs.kdeconnect.enable = true;

  # packages
  environment.systemPackages = with pkgs; [
    kate
  ];
}


# Notes
# Resolution Change Exmaple for Sunshine:
# xrandr --output DP-4 --mode 1920x1080 --rate 60 # Change to 1080p @ 60hz
