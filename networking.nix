{pkgs, ...}: {
  # firewall
  networking.firewall.enable = false;
  
  # services
  services.openssh.enable = true; # ssh server
  services.avahi = {
    enable = true;
    nssmdns = true;
    publish.enable = true;
    publish.addresses = true;
    publish.workstation = true;
  };
}
