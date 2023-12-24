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

    #games
    steam
    lutris

    wineWowPackages.stable
    winetricks

  ];

}
