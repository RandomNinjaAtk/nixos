{pkgs, ...}: {

  # Services
  services.getty.autologinUser = null; # auto login (change null to username)
  
  # packages
  environment.systemPackages = with pkgs; [
    # gamescope
  ];

}
