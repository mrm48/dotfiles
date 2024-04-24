
{ config, pkgs, ... }:

{

  # sway configuration
  #imports = [

   #../modules/sway

  #];

  home.packages = with pkgs; [

    #social
    obs-studio
    discord

    #tools
    mediawriter
    kate
    gitkraken
    librewolf
    vivaldi
    vivaldi-ffmpeg-codecs
    logseq

    waybar
    networkmanagerapplet

  ];

}
