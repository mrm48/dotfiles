{ inputs, outputs, lib, config, pkgs, ... }:
{

  imports = [

    # Console applications
    ./modules/console/init.nix

    # neovim
    ./modules/neovim/init.nix

  ]; 

  home.username = "matt";
  home.homeDirectory = "/home/matt";

  home.stateVersion = "23.11";

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-25.9.0"
    ];
  };

  home.packages = [

      #fonts
      pkgs.ubuntu_font_family
      (pkgs.nerdfonts.override { fonts = [ "UbuntuMono"]; })

      #tools
      pkgs.keepassxc
      pkgs.brave
      pkgs.gnome.dconf-editor

      #social
      pkgs.freetube

      #code
      pkgs.python3 # what is this needed for?
      pkgs.gcc # required for Treesitter

      #ui
      pkgs.papirus-icon-theme

  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  programs.home-manager.enable = true;

}
