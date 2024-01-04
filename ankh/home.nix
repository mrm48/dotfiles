
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
    steam
    lutris
    wineWowPackages.stable
    winetricks

    (writeShellScriptBin "setup-favorites" ''
      # Set up favorites for gnome convert this to an autostart script
      gsettings set org.gnome.shell favorite-apps "['Alacritty.desktop', 'firefox.desktop', 'org.gnome.Nautilus.desktop', 'com.obsproject.Studio.desktop', 'steam.desktop', 'freetube.desktop', 'brave-browser.desktop', 'net.lutris.Lutris.desktop' ]"
      '')

    ];

  wayland.windowManager.hyprland.settings = {
      monitor= [ "DP-1,1920x1080@144,0x0,1"
                 "HDMI-A-1,1920x1080@60,1920x0,1"
      ];
  };

}
