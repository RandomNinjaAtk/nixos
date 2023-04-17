{pkgs, ...}: {
  # boot changes
  boot.kernelPackages = pkgs.linuxPackages_latest; # kernel update
}
