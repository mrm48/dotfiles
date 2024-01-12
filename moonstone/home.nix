{ config, pkgs, ... }:

{

  # hyprland configuration
  imports = [

   ../modules/hypr/init.nix

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
        force_default_wallpaper = 1; # Set to 0 to disable the anime mascot wallpapers
      };
      exec-once = "waybar";
  };

}
