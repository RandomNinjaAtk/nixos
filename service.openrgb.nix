{pkgs, ...}: {
  # Enable openrgb
  boot.kernelModules = [ "i2c-dev" "i2c-piix4" ];
  services.hardware.openrgb.enable = true; # openrgb
}
