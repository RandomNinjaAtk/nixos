{pkgs, ...}: {
  
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  
  # Enable the Desktop Environment  
  # KDE
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.defaultSession = "plasmawayland";
  
  # Auto Login
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "gamer";
  
  
  # packages
  environment.systemPackages = with pkgs; [
    gamescope
  ];

  # autologin workaround (https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229)
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
}