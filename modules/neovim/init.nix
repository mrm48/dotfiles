{ config, pkgs, ... }:
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
