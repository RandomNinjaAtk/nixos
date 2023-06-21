{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.user01 = {
    /* The home.stateVersion option does not have a default and must be set */
    home.stateVersion = "23.05";
    xdg.configFile."sunshine/apps.json".text = builtins.toJSON
    {
      env = "/run/current-system/sw/bin:/run/wrappers/bin:/home/sohare/.nix-profile/bin:/etc/profiles/per-user/sohare/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin";
      apps = [
        {
           name = "Steam";
           output = "steam.txt";
           detached = ["${pkgs.util-linux}/bin/setsid ${pkgs.steam}/bin/steam steam://open/bigpicture"];
           image-path = "steam.png";
        }
      ];
    };
    xdg.configFile."sunshine/sunshine.conf".text = ''
      global_prep_cmd = [{"do":"${pkgs.libsForQt5.libkscreen}/bin/kscreen-doctor output.1.mode.12","undo":"${pkgs.libsForQt5.libkscreen}/bin/kscreen-doctor output.1.mode.0"}]
      output_name = 1
    '';

    nixpkgs.config = {
      allowUnfree = true;
    };
  };

  };
}
