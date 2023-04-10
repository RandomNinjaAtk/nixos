{pkgs, ...}: {

  # packages
  environment.systemPackages = with pkgs; [
    gamescope
  ];

}
