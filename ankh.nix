
{ config, pkgs, ... }:

{

  home.packages = [

    #tools
    pkgs.gnome.gnome-boxes
    pkgs.gnome.gnome-tweak

    #game dev testing
    pkgs.godot_4

  ];

}
