{pkgs, ...}: {

  environment.systemPackages = with pkgs; [ steam ];
  services.udev.enable = true;
  services.udev.extraRules = ''
    # Your rule goes here
    KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"
  '';

  security.wrappers = {
    steam = {
      source = "${pkgs.steam}/bin/steam";
      capabilities = "cap_sys_admin+ep";
      owner = "root";
      group = "root";
    };
  }; 


  systemd.user.services.steam = {
    script = "/run/current-system/sw/bin/env /run/wrappers/bin/steam steam://open/bigpicture";

    unitConfig = {
      Description = "Steam is a gaming service";
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
# systemctl --user restart steam.service
