{pkgs, ...}: {
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  # for a WiFi printer
  services.avahi.openFirewall = true;
}

# Reference: https://nixos.wiki/wiki/Printing
