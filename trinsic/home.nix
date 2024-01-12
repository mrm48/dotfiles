{ config, pkgs, ... }:

{

  home.packages = with pkgs; [

    #tools
    librewolf
    logseq
    kate

    #gnome extensions
    gnome.gnome-tweaks
    chrome-gnome-shell
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock
    gnomeExtensions.dash-to-panel
    gnomeExtensions.caffeine

    #social
    thunderbird
    discord

    (writeShellScriptBin "setup-favorites" ''
      # Set up favorites for gnome convert this to an autostart script
      gsettings set org.gnome.shell favorite-apps "['Alacritty.desktop', 'librewolf.desktop', 'org.kde.kate.desktop', 'logseq.desktop', 'thunderbird.desktop', 'freetube.desktop', 'brave-browser.desktop' ]"
    '')
  ];

}
