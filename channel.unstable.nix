{pkgs, ...}: {
  # Switch system to usntable channel
  system.autoUpgrade.channel = "https://nixos.org/channels/nixos-unstable/";
}
