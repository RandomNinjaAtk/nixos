{pkgs, ...}: {

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # packages
  environment.systemPackages = with pkgs; [
    kate
  ];
}
