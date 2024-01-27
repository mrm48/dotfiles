{ config, pkgs, ... }:

{

  # hyprland configuration
  imports = [

   ../modules/hypr

  ]; 

  home.packages = with pkgs; [

    #tools
    librewolf

    #xfce themes
    arc-icon-theme
    arc-theme

    #hyprland tools
    waybar

    (writeShellScriptBin "setup-favorites" ''

      # Set up favorites for gnome convert this to an autostart script
      gsettings set org.gnome.shell favorite-apps "['Alacritty.desktop', 'librewolf.desktop', 'freetube.desktop' ]"

    '')
  ];
  
  wayland.windowManager.hyprland.settings = {
      misc = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        force_default_wallpaper = 0; # Set to 0 to disable the anime mascot wallpapers
      };
      exec-once = [ "waybar" "hyprpaper" ];
  };

  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = /home/matt/Pictures/walls/wallpaper

    wallpaper = eDP-1,/home/matt/Pictures/walls/wallpaper
  '';

}
