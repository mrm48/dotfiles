
{ config, pkgs, ... }:

{

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

    #hyprland configuration stuff
    wofi

    (writeShellScriptBin "setup-favorites" ''
      # Set up favorites for gnome convert this to an autostart script
      gsettings set org.gnome.shell favorite-apps "['Alacritty.desktop', 'firefox.desktop', 'org.gnome.Nautilus.desktop', 'com.obsproject.Studio.desktop', 'steam.desktop', 'freetube.desktop', 'brave-browser.desktop', 'net.lutris.Lutris.desktop' ]"
    '')
  ];

}
