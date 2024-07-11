{ inputs, outputs, lib, config, pkgs, ... }:
{

  # console setup and nvim
  imports = [

    ./modules/console
    ./modules/neovim

  ]; 

  home.username = "matt";
  home.homeDirectory = "/home/matt";

  home.stateVersion = "24.05";

  nixpkgs.config = {
    allowUnfree = true;
  };

  home.packages = with pkgs; [

      #fonts
      ubuntu_font_family
      (nerdfonts.override { fonts = [ "Ubuntu" "UbuntuMono" "FiraMono" "Hack" ]; })
      cantarell-fonts

      #tools
      keepassxc
      gimp
      inkscape
      kdePackages.plasma-browser-integration
      kdePackages.kclock
      mpv
      vlc

      #social
      freetube
      kdePackages.kasts

      #code
      python3 # required for gnome extensions
      gcc # required for Treesitter
      zed-editor

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
