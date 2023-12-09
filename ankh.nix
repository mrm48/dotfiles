
{ config, pkgs, ... }:

{

  home.packages = [

    #tools
    pkgs.gnome.gnome-boxes

    #game dev testing
    pkgs.godot_4

  ];

}
