{pkgs, ...}: {

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Remove packages
  services.xserver.excludePackages = [ pkgs.xterm ]; # remove xterm
  
  # programs
  
  # hardware
  hardware.steam-hardware.enable = true;

  # packages
  environment.systemPackages = with pkgs; [
    mlocate
    htop
    wget
    curl
    gping
    wayvnc
    appimage-run
    vmware-horizon-client
    rustdesk
    wayland-utils
    gpu-viewer
    clinfo
    glxinfo
    vulkan-tools
  ];
}

# clinfo
# eglinfo
# glxinfo
# vulkaninfo
# wayland-info
