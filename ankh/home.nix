
{ config, pkgs, ... }:

{

  home.packages = [

    #gnome extensions
    pkgs.gnome.gnome-boxes
    pkgs.gnome.gnome-tweaks
    pkgs.chrome-gnome-shell
    pkgs.gnomeExtensions.blur-my-shell
    pkgs.gnomeExtensions.dash-to-dock
    pkgs.gnomeExtensions.dash-to-panel
    pkgs.gnomeExtensions.blur-my-shell
    pkgs.gnomeExtensions.caffeine

    #social
    pkgs.obs-studio

    #game dev testing
    pkgs.godot_4

  ];

}
