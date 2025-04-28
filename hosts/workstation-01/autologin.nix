{ config, pkgs, ... }:
{
   # Enable automatic login for the user.
   services.displayManager.autoLogin = {
    enable = true;
    user = "user";
  };
}
