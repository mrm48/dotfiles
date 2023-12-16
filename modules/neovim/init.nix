{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      nvim-jdtls
      lsp-zero-nvim
      nvim-treesitter
    ];
    extraConfig = ''
      luafile /home/matt/.dotfiles/modules/neovim/globalopts.lua
      luafile /home/matt/.dotfiles/modules/neovim/set.lua
    '';
    extraLuaConfig = ''
        local parser_install_dir = vim.fn.stdpath("cache") .. "/treesitters"
        vim.fn.mkdir(parser_install_dir, "p")
        -- Prevents reinstall of treesitter plugins every boot
        vim.opt.runtimepath:append(parser_install_dir)

        require'nvim-treesitter.configs'.setup {
          ensure_installed = "all",
          parser_install_dir = parser_install_dir, 
          highlight = {
            enable = true,
          },
        }
    '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
