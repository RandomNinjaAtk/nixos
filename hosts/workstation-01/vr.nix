{ config, pkgs, ... }:
let
  unstableTarball =
    fetchTarball
      https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
in
{
  nixpkgs.config = {
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    # other apps
  ];

  # enable steamvr wired/wireless
  programs.adb.enable = true;
  services.wivrn = {
    enable = true;
    autoStart = true;
    defaultRuntime = true;
    openFirewall = true;
    package = pkgs.unstable.wivrn;
  };

  programs.alvr = {
    enable = true;
    openFirewall = true;
    package = pkgs.unstable.alvr;
  };

  boot.kernelPatches = [
    {
      name = "amdgpu-ignore-ctx-privileges";
      patch = pkgs.fetchpatch {
        name = "cap_sys_nice_begone.patch";
        url = "https://github.com/Frogging-Family/community-patches/raw/master/linux61-tkg/cap_sys_nice_begone.mypatch";
        hash = "sha256-Y3a0+x2xvHsfLax/uwycdJf3xLxvVfkfDVqjkxNaYEo=";
      };
    }
  ];  
}
