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
    pkgs.hplip # HP printers.
    pkgs.postscript-lexmark # Postscript drivers for Lexmark
    pkgs.samsung-unified-linux-driver # Proprietary Samsung Drivers
    pkgs.splix # Samsung Printer Language
    pkgs.brlaser # Brother Printers
    pkgs.cnijfilter2 # Cannon Proprietary 
  ];
}

# Reference: https://nixos.wiki/wiki/Printing
