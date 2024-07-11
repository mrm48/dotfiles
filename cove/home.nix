
{ config, pkgs, ... }:

{

  # hypr configuration
  imports = [

   ../modules/hypr

  ];

  home.packages = with pkgs; [

    #social
    obs-studio
    discord

    #tools
    mediawriter
    kate
    #gitkraken
    librewolf
    brave
    #logseq

    steam
    lutris
    protonup-qt

    waybar
    networkmanagerapplet

    #programming
    jdk21
    maven

  ];

}
