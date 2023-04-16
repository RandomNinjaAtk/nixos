{ config, pkgs, ... }: {
  imports =
    [ 
      ./channel.unstable.nix
      ./desktop.htpc.nix
      ./hardware.audio.nix
      ./hardware.radeon.nix
      ./hardware.bluetooth.nix
      ./services.sunshine.nix
      ./services.steam.nix
    ];
}
