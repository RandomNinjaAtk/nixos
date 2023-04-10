{pkgs, ...}: {

  environment.systemPackages = with pkgs; [ sunshine ];
  services.udev.enable = true;
  services.udev.extraRules = ''
    # Your rule goes here
    KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"
  '';

  security.wrappers = {
    sunshine = {
      source = "${pkgs.sunshine}/bin/sunshine";
      capabilities = "cap_sys_admin+ep";
      owner = "root";
      group = "root";
    };
  }; 


  systemd.user.services.sunshine = {
    script = "/run/current-system/sw/bin/env /run/wrappers/bin/sunshine";

    unitConfig = {
      Description = "Sunshine is a Game stream host for Moonlight.";
      StartLimitIntervalSec = 500;
      StartLimitBurst = 5;
    };

    serviceConfig = {
      Environment = "WAYLAND_DISPLAY=wayland-1";
      # auto restart
      Restart = "on-failure";
      RestartSec = "5s";
    };
    wantedBy = [ 
      "graphical-session.target"
    ];
  };
}

# Get Service Status
# systemctl --user restart sunshine.service
