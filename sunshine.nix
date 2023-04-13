{pkgs, ...}: {

  # Install sunshine
  environment.systemPackages = with pkgs; [ sunshine ];
  
  systemd.user.services.sunshine = {
    description = "Sunshine self-hosted game stream host for Moonlight.";
    startLimitIntervalSec = 500;
    startLimitBurst = 5;
    wantedBy = [ "graphical-session.target" ];

    serviceConfig = {
      Restart = "on-failure";
      RestartSec = "5s";
      ExecStart = "${pkgs.sunshine}/bin/sunshine";
    };
  };
}

# Get Service Status
# systemctl --user restart sunshine
