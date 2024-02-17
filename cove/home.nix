
{ config, pkgs, ... }:

{

  # hyprland configuration
  imports = [

   ../modules/hypr

  ]; 

  home.packages = with pkgs; [

    #social
    obs-studio

    #game dev testing
    godot_4

    #tools
    mediawriter
    libsForQt5.kate

    #games
    protonup-qt

    waybar

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
        "waybar"
      ];
  };

  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = /home/matt/Pictures/walls/wallpaper

    wallpaper = DP-1,/home/matt/Pictures/walls/wallpaper
    wallpaper = HDMI-A-1,/home/matt/Pictures/walls/wallpaper
  '';

}
