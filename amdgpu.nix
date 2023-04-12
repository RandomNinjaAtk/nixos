{pkgs, ...}: {
  # boot changes
  boot.initrd.kernelModules = ["amdgpu"]; # enable 
  
  # services
  services.xserver.videoDrivers = ["amdgpu"]; # amd gpu support radv
}

# References:
# https://nixos.wiki/wiki/AMD_GPU
