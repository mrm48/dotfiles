{
  programs.neovim = {
    enable = true;
    plugins = [
      {
        plugin = pkgs.vimPlugins.nvim-jdtls;
      }
    ];
  };
}
