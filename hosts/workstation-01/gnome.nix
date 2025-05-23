{ config, lib,  pkgs, ... }:
let
  unstableTarball =
    fetchTarball
      https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
in
{
  nixpkgs.config = {
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };

  # more info: https://wiki.nixos.org/wiki/GNOME
  
  services.xserver = {
    enable = false; # enable x11?
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    desktopManager.gnome = {
      enable = true;
    };
  };
  
  # ensure gnome-settings-daemon udev rules are enabled: 
  services.udev.packages = [ pkgs.gnome-settings-daemon ];
  services.sysprof.enable = true; # Profiling (with sysprof)
  hardware.sensor.iio.enable = true; # Automatic screen rotation
  systemd.services."getty@tty1".enable = false; # fix login network errors https://discourse.nixos.org/t/gnome-display-manager-fails-to-login-until-wi-fi-connection-is-established/50513/16
  systemd.services."autovt@tty1".enable = false;  # fix login network errors

  # Remove packages
  services.xserver.excludePackages = [ pkgs.xterm ]; # remove xterm
  
  # Other Packages
  environment.systemPackages = with pkgs; [
    # extensions
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-panel
    gnomeExtensions.caffeine
    gnomeExtensions.tiling-shell
    gnomeExtensions.vitals
    gnomeExtensions.burn-my-windows
    gnomeExtensions.media-controls
    gnomeExtensions.gsconnect
    gnomeExtensions.restart-to
    gnomeExtensions.blur-my-shell
    gnomeExtensions.hot-edge
    gnomeExtensions.arcmenu
    # other apps
    gnome-randr
    adwaita-icon-theme
    gnome-themes-extra
    gnome-extension-manager
    gnome-menus
    dconf-editor
  ];
  
  services.dbus.packages = with pkgs; [ gnome2.GConf ];
  
  # dconf settings
  programs.dconf = {
    enable = true;
    profiles.user.databases = [
      {
        lockAll = true; # prevents overriding
        # for monitoring gnome changes: dconf watch /
        settings = with lib.gvariant; {
          "org/gnome/mutter" = {
            edge-tiling = false;
            dynamic-workspaces = true;
            experimental-features = [
              "variable-refresh-rate"
              "scale-monitor-framebuffer"
            ];
          }; 
          
          "org/gnome/desktop/interface" = {
	    enable-animations = true;
	    gtk-theme = "Adwaita";
	    icon-theme = "Adwaita";
	    color-scheme= "prefer-dark";
	    application-prefer-dark-theme = true;
	    clock-format = "12h";
	    clock-show-seconds = true;
	    clock-show-weekday = true;
	    show-battery-percentage = true;
	    accent-color = "purple";
          };        
                      
          "org/gnome/desktop/peripherals/keyboard" = {
              numlock-state = true;
          };
          
          "org/gnome/shell/weather" = {
            automatic-location = true;
            locations = "[<(uint32 2, <('Greenwood', 'KGRD', true, [(0.59772678356143749, -1.4338703949606211)], [(0.59682231903646898, -1.433993719925567)])>)>, <(uint32 2, <('Greenwood', 'KGWO', true, [(0.58455439972420076, -1.5722556140357817)], [(0.58496860126228412, -1.5739296814944173)])>)>]";
          };
          
          "org/gnome/Weather" = {
            locations = "[<(uint32 2, <('Greenwood', 'KGRD', true, [(0.59772678356143749, -1.4338703949606211)], [(0.59682231903646898, -1.433993719925567)])>)>]";
          };
                      
          "org/gnome/gnome-session" = {
            auto-save-session = true;
            auto-save-session-one-shot = true;
          };

          "org/gnome/settings-daemon/plugins/power" = {
            sleep-inactive-ac-type = "nothing";
            power-button-action = "nothing";
          };
          
          "org/gnome/desktop/wm/preferences" = {
            button-layout = "appmenu:minimize,maximize,close";
          };
          
          "org/gnome/system/location" = {
            enabled = true;
          };
          
          "org/gtk/settings/file-chooser" = {
            clock-format = "12h";
            sort-directories-first = true;
          };
          
          "org/gnome/TextEditor" = {
            show-line-numbers = true;
          };
          
          "org/gnome/desktop/background" = {
            primary-color = "#241f31";
            picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/blobs-l.svg";
            picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/blobs-d.svg";
          };
          
          "org/gnome/desktop/screensaver" = {
            primary-color = "#241f31";
            picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/blobs-d.svg";
          };
          
          "org/gnome/shell/world-clocks" = {
      	     locations = "[<(uint32 2, <('Seattle', 'KBFI', true, [(0.82983133145337307, -2.134775231953554)], [(0.83088509144255718, -2.135097419733472)])>)>, <(uint32 2, <('Lafayette', 'KLFT', true, [(0.52712821531826681, -1.6055817161715245)], [(0.52750988391909293, -1.6060492375182565)])>)>, <(uint32 2, <('New York', 'KNYC', true, [(0.71180344078725644, -1.2909618758762367)], [(0.71059804659265924, -1.2916478949920254)])>)>]";
          };
          
          "org/gnome/shell" = {
            favorite-apps = [
              "org.gnome.Nautilus.desktop"
              "org.gnome.Console.desktop"
              "io.gitlab.news_flash.NewsFlash.desktop" # flatpak version
              "firefox.desktop" 
              "com.discordapp.Discord.desktop" # flatpak version
              "com.heroicgameslauncher.hgl.desktop" # flatpak version
              "steam.desktop" # non flatpak version
              "signal.desktop" 
              # "com.valvesoftware.Steam.desktop" # flatpak version
            ]; # search /var/lib/flatpak/ or /nix/store/ - find /nix/store/  -name "*.desktop" | grep console
            disable-user-extensions = false;
            enabled-extensions = [
              "appindicatorsupport@rgcjonas.gmail.com" 
              "caffeine@patapon.info"
              "dash-to-panel@jderose9.github.com"
              "Vitals@CoreCoding.com"
              "burn-my-windows@schneegans.github.com"
              "mediacontrols@cliffniff.github.com"
              "gsconnect@andyholmes.github.io"
              "tilingshell@ferrarodomenico.com"
              "blur-my-shell@aunetx"
              "restartto@tiagoporsch.github.io"
              "hotedge@jonathan.jdoda.ca"
              "user-theme@gnome-shell-extensions.gcampax.github.com"
              "arcmenu@arcmenu.com"
              #"clipboard-indicator@tudmotu.com" 
              #"tailscale@joaophi.github.com"
              #"unite@hardpixel.eu" 
              #"pip-on-top@rafostar.github.com"
              #"cloudflare-warp-toggle@khaled.is-a.dev"
            ]; # get uuid: gnome-extensions list
          };
        
          "org/gnome/shell/extensions/dash-to-panel" = {
            animate-appicon-hover = true;
            highlight-appicon-hover = true;
            panel-lengths = ''{"GBT-0x000011a2":100}'';
            panel-element-positions = ''{"GBT-0x000011a2":[{"element":"showAppsButton","visible":false,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"stackedTL"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":true,"position":"stackedBR"}]}'';
            appicon-style = "NORMAL"; # SYMBOLIC NORMAL GRAYSCALE
            global-border-radius = mkInt32 2;
            panel-top-bottom-padding = mkInt32 4;
            panel-side-padding = mkInt32 0;
            panel-top-bottom-margins = mkInt32 4;
            panel-side-margins = mkInt32 8;
            trans-use-custom-opacity = true;
            hide-overview-on-startup = true;
            dot-position = "BOTTOM";
            dot-style-focused = "DOTS";
            dot-style-unfocused = "DOTS";
            appicon-margin = mkInt32 4;
            appicon-padding = mkInt32 4;
          };
        
          "org/gnome/shell/extensions/arcmenu" = {
            hide-overview-on-startup = true;
            position-in-panel = "Left";
            menu-layout = "Windows";
            search-provider-open-windows = true;
            search-provider-recent-files = true;
            highlight-search-result-terms = true;
          };
        };
      }
    ];
  };
}
