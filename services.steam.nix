{pkgs, ...}: {
 
  # programs
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    gamescopeSession.enable = false; # Whether to enable GameScope Session.
    #gamescopeSession = true; # Run a GameScope driven Steam session from your display-manager
  }; # steam

  # install/enable gamescope
  programs.gamescope.enable = true;

  # steam hardware
  hardware.steam-hardware.enable = true;

  systemd.user.services.steam = {
    description = "Start steam gamepadui";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Restart = "always";
      RestartSec = "5s";
      ExecStart = "${pkgs.gamescope}/bin/gamescope -w 1920 -h 1080 -e -f ${pkgs.steam}/bin/steam -gamepadui -steamos";
    };
  };
}

# Get Service Status
# systemctl --user restart steam.service
