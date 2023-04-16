{ config, pkgs, ... }: {
  imports =
    [ 
      ./channel.unstable.nix
      ./desktop.kde.nix
      ./hardware.audio.nix
      ./hardware.radeon.nix
      ./hardware.bluetooth.nix
      ./services.sunshine.nix
      ./customizations.nix
    ];
}
