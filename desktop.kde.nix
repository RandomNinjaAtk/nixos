{pkgs, ...}: {

  
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  
  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.defaultSession = "plasmawayland";
  services.xserver.desktopManager.plasma5.bigscreen.enable = true;
  
  # Enable RDP
  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "startplasma-x11";
  #networking.firewall.allowedTCPPorts = [ 3389 ];

  # Programs 
  programs.kdeconnect.enable = true;

  # packages
  environment.systemPackages = with pkgs; [
    # kate
  ];
}


# Notes
# Resolution Change Exmaple for Sunshine:
# kscreen-doctor output.DP-2.mode.1920x1080@120
# kscreen-doctor output.DP-2.mode.3440x1440@144
# xrandr --output DP-2 --mode 1920x1080 --rate 60 # Change to 1080p @ 60hz
