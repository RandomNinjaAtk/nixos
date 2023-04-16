{ config, pkgs, ... }: {
  imports =
    [ 
      ./channel.unstable.nix
      ./desktop.kde.nix
      ./hardware.audio.nix
      ./hardware.radeon.nix
      ./hardware.bluetooth.nix
      ./hardware.razer.nix
      ./services.sunshine.nix
      ./services.openrgb.nix
      ./customizations.nix
    ];
}
