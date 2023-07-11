{pkgs, ...}: {
 
 # programs
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  }; # steam
  
  # steam hardware
  hardware.steam-hardware.enable = true;

  systemd.user.services.steam = {
    description = "Start steam big picture";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Restart = "always";
      RestartSec = "5s";
      ExecStart = "${pkgs.steam}/bin/steam steam://open/bigpicture -no-cef-sandbox";
    };
  };
}

# Get Service Status
# systemctl --user restart steam.service
