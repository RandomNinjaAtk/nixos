{pkgs, ...}: {
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  # for a WiFi printer
  services.avahi.openFirewall = true;
  
  # additional drivers
  services.printing.drivers = [ 
    pkgs.gutenprint
    pkgs.gutenprintBin 
  ];
}

# Reference: https://nixos.wiki/wiki/Printing
