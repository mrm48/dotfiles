{ config, pkgs, ... }:

{

  home.packages = [

    #tools
    pkgs.librewolf
    pkgs.logseq

    #social
    pkgs.thunderbird
    pkgs.discord

    #games
    pkgs.steam

  ];

}
