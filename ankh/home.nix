
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
    hyprpaper

    (writeShellScriptBin "setup-favorites" ''
      # Set up favorites for gnome convert this to an autostart script
      gsettings set org.gnome.shell favorite-apps "['Alacritty.desktop', 'firefox.desktop', 'org.gnome.Nautilus.desktop', 'com.obsproject.Studio.desktop', 'steam.desktop', 'freetube.desktop', 'brave-browser.desktop', 'net.lutris.Lutris.desktop' ]"
      '')

    ];


      programs.wofi = {
        enable = true;
        style = ''

          window {
          margin: 0px;
          border: 1px solid #bd93f9;
          background-color: #282a36;
          }
          
          #input {
          margin: 5px;
          border: none;
          color: #f8f8f2;
          background-color: #44475a;
          }
          
          #inner-box {
          margin: 5px;
          border: none;
          background-color: #282a36;
          }
          
          #outer-box {
          margin: 5px;
          border: none;
          background-color: #282a36;
          }
          
          #scroll {
          margin: 0px;
          border: none;
          }
          
          #text {
          margin: 5px;
          border: none;
          color: #f8f8f2;
          } 
          
          #entry.activatable #text {
          color: #282a36;
          }
          
          #entry > * {
          color: #f8f8f2;
          }
          
          #entry:selected {
          background-color: #44475a;
          }
          
          #entry:selected #text {
          font-weight: bold;
          }
        '';
    };

}
