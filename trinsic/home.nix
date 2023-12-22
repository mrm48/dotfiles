{ config, pkgs, ... }:

{

  home.packages = [

    #tools
    pkgs.librewolf
    pkgs.logseq

    #gnome extensions
    pkgs.gnome.gnome-tweaks
    pkgs.chrome-gnome-shell
    pkgs.gnomeExtensions.blur-my-shell
    pkgs.gnomeExtensions.dash-to-dock
    pkgs.gnomeExtensions.dash-to-panel
    pkgs.gnomeExtensions.caffeine

    #social
    pkgs.thunderbird
    pkgs.discord

    #games
    pkgs.steam
    pkgs.lutris

    pkgs.wineWowPackages.stable
    pkgs.winetricks

  ];

}
