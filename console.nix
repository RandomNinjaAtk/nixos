{pkgs, ...}: {

  # Services
  services.getty.autologinUser = null; # auto login
  
  # packages
  environment.systemPackages = with pkgs; [
    # gamescope
  ];

}
