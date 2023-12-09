{ config, pkgs, ... }:

{

  home.packages = [

    #tools
    pkgs.librewolf
    pkgs.logseq

    #social
    pkgs.thunderbird

    #games
    pkgs.steam

  ];

}
