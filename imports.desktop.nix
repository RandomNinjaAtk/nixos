{ config, pkgs, ... }: {
  imports =
    [ 
      ./desktop.kde.nix
      ./packages.desktop.nix
      ./kernel.nix
      ./channel.unstable.nix
      ./hardware.audio.nix
      ./hardware.radeon.nix
      ./hardware.bluetooth.nix
      ./hardware.razer.nix
      ./enable.printing.nix
      ./services.sunshine.nix
      ./services.openrgb.nix
      ./services.cockpit.nix
      ./networking.nix
      ./customizations.nix
    ];
}
