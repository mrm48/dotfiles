
{ config, pkgs, ... }:

{

  # hyprland configuration
  imports = [

   ../modules/hypr/init.nix

  ]; 

  home.packages = with pkgs; [

    #gnome extensions
    gnome.gnome-boxes
    gnome.gnome-tweaks
    chrome-gnome-shell
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock
    gnomeExtensions.dash-to-panel
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine

    #social
    obs-studio

    #game dev testing
    godot_4

    #tools
    mediawriter

    #games
    protonup-qt

    (writeShellScriptBin "setup-favorites" ''
      # Set up favorites for gnome convert this to an autostart script
      gsettings set org.gnome.shell favorite-apps "['Alacritty.desktop', 'firefox.desktop', 'org.gnome.Nautilus.desktop', 'com.obsproject.Studio.desktop', 'steam.desktop', 'freetube.desktop', 'net.lutris.Lutris.desktop' ]"
      '')

    ];

  wayland.windowManager.hyprland.settings = {
      monitor= [ "DP-1,1920x1080@144,0x0,1"
                 "HDMI-A-1,1920x1080@60,1920x0,1"
      ];
      misc = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        force_default_wallpaper = 0; # Set to 0 to disable the anime mascot wallpapers
      };
      exec-once = [ 
        "hyprpaper"
      ];
  };

  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = /home/matt/Pictures/walls/wallpaper

    wallpaper = DP-1,/home/matt/Pictures/walls/wallpaper
    wallpaper = HDMI-A-1,/home/matt/Pictures/walls/wallpaper
  '';

}
