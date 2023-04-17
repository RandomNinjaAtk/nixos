{ config, pkgs, ... }: {
  imports =
    [ 
      ./desktop.htpc.nix
      ./packages.htpc.nix
      ./kernel.nix
      ./channel.unstable.nix
      ./hardware.audio.nix
      ./hardware.radeon.nix
      ./hardware.bluetooth.nix
      ./hardware.razer.nix
      ./services.sunshine.nix
      ./services.openrgb.nix
      ./packages.desktop.nix
      ./networking.nix
    ];
}
