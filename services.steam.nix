{pkgs, ...}: {
 
 # programs
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    gamescopeSession.enable = true; # Whether to enable GameScope Session.
    #gamescopeSession = true; # Run a GameScope driven Steam session from your display-manager
  }; # steam
  
  # steam hardware
  hardware.steam-hardware.enable = true;

  systemd.user.services.steam = {
    description = "Start steam big picture";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Restart = "always";
      RestartSec = "5s";
      ExecStart = "${pkgs.gamescope}/bin/gamescope -w 1920 -h 1080 -f ${pkgs.steam}/bin/steam -gamepadui -no-cef-sandbox";
    };
  };
}

# Get Service Status
# systemctl --user restart steam.service
