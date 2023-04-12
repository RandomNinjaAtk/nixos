{pkgs, ...}: {
  # boot changes
  boot.initrd.kernelModules = ["amdgpu"]; # enable 
  
  # services
  services.xserver.videoDrivers = ["amdgpu"]; # amd gpu support radv
  
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      # OpenCL ICD definition for AMD GPUs using the ROCm stack
      rocm-opencl-icd
      # OpenCL runtime for AMD GPUs, part of the ROCm stack
      rocm-opencl-runtime
      # AMD Open Source Driver For Vulkan
      amdvlk
      # Hardware-accelerated video playpack
      # VDPAU driver for the VAAPI library
      vaapiVdpau
      # VDPAU driver with OpenGL/VAAPI backend
      libvdpau-va-gl
      # Tool to query the Video Decode and Presentation API for Unix (VDPAU) abilities of the system
      vdpauinfo
    ];
    extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
    ];
  };
   
  user.packages = with pkgs; [
    # Inspect and manipulate PCI devices
    pciutils
    # Print all known information about all available OpenCL platforms and devices in the system
    clinfo
    # Top-like tool for viewing AMD Radeon GPU utilization
    radeontop
    # Application to read current clocks of AMD Radeon cards
    radeon-profile
    # ROCm Application for Reporting System Info
    rocminfo
    # System management interface for AMD GPUs supported by ROCm
    rocm-smi
    # Platform runtime for ROCm
    rocm-runtime
    # OpenCL runtime for AMD GPUs, part of the ROCm stack
    rocm-opencl-runtime
    # CMake modules for common build tasks for the ROCm stack
    rocm-cmake
    # Radeon open compute thunk interface
    rocm-thun
  ];
}

# References:
# https://nixos.wiki/wiki/AMD_GPU
# https://codeberg.org/totoroot/dotfiles/src/branch/main/modules/hardware/radeon.nix
