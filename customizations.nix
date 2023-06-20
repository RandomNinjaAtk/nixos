{pkgs, ...}: {
        
  services.fprintd.enable = true; # finger print reader
  services.flatpak.enable = true; # flatpak
  services.fwupd.enable = true; # firmware updates
  services.sunshine.enable = true; sunshine
  
}
