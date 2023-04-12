{pkgs, ...}: {
  # boot changes
  boot.initrd.kernelModules = ["amdgpu"]; # enable 
  
  # hardware
  hardware.opengl.enable = true; 
  hardware.opengl.driSupport = true; # enable vulkan
  hardware.opengl.driSupport32Bit = true; # enable vulkan
  
  # services
  services.xserver.videoDrivers = ["amdgpu"]; # amd gpu support radv
  
  # packages   
  environment.systemPackages = with pkgs; [
    # Top-like tool for viewing AMD Radeon GPU utilization
    radeontop
  ];
}

# References:
# https://nixos.wiki/wiki/AMD_GPU
# https://codeberg.org/totoroot/dotfiles/src/branch/main/modules/hardware/radeon.nix
