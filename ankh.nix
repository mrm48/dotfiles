
{ config, pkgs, ... }:

{

  home.packages = [

    #tools
    pkgs.gnome.gnome-boxes
    pkgs.gnome.gnome-tweaks
    pkgs.chrome-gnome-shell

    #game dev testing
    pkgs.godot_4

  ];

}
