{pkgs, ...}:
let
  unstable = import (import ./nixpkgs-src.nix).unstable { config = {allowUnfree = true; }; };
  #my_steam = (pkgs.steam.override { nativeOnly = true; });
  my_steam = unstable.steam;
  steam_autostart = (pkgs.makeAutostartItem { name = "steam"; package = my_steam; });
in
{
  
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  
  # Enable the GNOME Desktop Environment  
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "gamer";
  
  
  # packages
  environment.systemPackages = with pkgs; [
    # gamescope
    my_steam
    steam_autostart
    steam-run
  ];

  # autologin workaround (https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229)
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
}
