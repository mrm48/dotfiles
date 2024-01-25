{ config, pkgs, ... }:

{

  home.packages = with pkgs; [

    #tools
    librewolf
    logseq
    kate

    #social
    thunderbird
    discord

  ];

}
