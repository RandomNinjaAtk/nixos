{pkgs, ...}: {

  # Install sunshine
  environment.systemPackages = with pkgs; [ sunshine ];
  
  systemd.user.services.sunshine = {
    Description = "Sunshine self-hosted game stream host for Moonlight.";
    StartLimitIntervalSec = 500;
    StartLimitBurst = 5;
    wantedBy = [ "graphical-session.target" ];

    serviceConfig = {
      Restart = "on-failure";
      RestartSec = "5s";
      ExecStart = "${pkgs.sunshine}/bin/sunshine";
    };
  };
}

# Get Service Status
# systemctl --user restart sunshine.service
