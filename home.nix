{ inputs, outputs, lib, config, pkgs, ... }:
{

  # console setup and nvim
  imports = [

    ./modules/console/init.nix
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

  home.packages = with pkgs; [

      #fonts
      ubuntu_font_family
      (nerdfonts.override { fonts = [ "UbuntuMono" ]; })

      #tools
      keepassxc
      brave
      gnome.dconf-editor

      #social
      freetube

      #code
      python3 # what is this needed for?
      gcc # required for Treesitter

      #ui
      papirus-icon-theme

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
