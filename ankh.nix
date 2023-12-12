
{ config, pkgs, ... }:

{

  home.packages = [

    #tools
    pkgs.gnome.gnome-boxes
    pkgs.gnome.gnome-tweaks
    pkgs.chrome-gnome-shell
    pkgs.gnomeExtensions.blur-my-shell
    pkgs.gnomeExtensions.dash-to-dock
    pkgs.gnomeExtensions.dash-to-panel
    pkgs.gnomeExtensions.caffeine

    #game dev testing
    pkgs.godot_4

  ];

}
