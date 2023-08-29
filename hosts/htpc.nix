{ config, pkgs, ... }: {
  imports = [
     ./services.sunshine.nix
     ./services.steam.nix
     #./samba.nix
  ];

  # set internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  # Bootloader.
  boot.kernelPackages = pkgs.linuxPackages_latest; # kernel update
  boot.supportedFilesystems = [ "ntfs" ];
  boot.initrd.kernelModules = ["amdgpu"];
  services.xserver.videoDrivers = ["amdgpu"];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # desktop environment
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.defaultSession = "plasma"; #plasma or plasmawayland or plasma-bigscreen-wayland or steam
  services.xserver.displayManager.sddm.autoNumlock = true; # enable numlock 

  # Enable AutoLogin
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "user";
  systemd.services."getty@tty1".enable = false; # autologin workaround (https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229)
  systemd.services."autovt@tty1".enable = false; # autologin workaround (https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229)

  # hardware
  hardware.cpu.intel.updateMicrocode = true;
  hardware.cpu.amd.updateMicrocode = true;
  hardware.bluetooth.enable = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;

  # networking
  networking.firewall.enable = false;

  # services
  services.openssh.enable = true; # ssh
  services.hardware.openrgb.enable = true; # openrgb
  services.sunshine.enable = true; # custom sunshine module
  services.flatpak.enable = true; # flatpak
  services.fwupd.enable = true; # firmware updates
  services.locate.enable = true; # enable locate services

  # Avahi
  services.avahi = {
    enable = true;
    reflector = true;
    nssmdns = true;
    openFirewall = true;
    publish = {
      enable = true;
      addresses = true;
      userServices = true;
      workstation = true;
    };
  };

  # programs
  programs.gamemode.enable = true; # for steam

  # Remove packages
  services.xserver.excludePackages = [ pkgs.xterm ]; # remove xterm

  # Packages
  environment.systemPackages = with pkgs; [
    # PACKAGES
    firefox
    moonlight-qt
    plex-media-player
    jellyfin-media-player
    kodi
  ];
}
