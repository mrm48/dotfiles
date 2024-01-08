{ config, pkgs, lib, ... }:
let
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
  });
in
  {
    imports = [
      nixvim.homeManagerModules.nixvim
    ];

  programs.nixvim = {
      enable = true;
      colorschemes.gruvbox.enable = true;
      plugins.lightline.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
