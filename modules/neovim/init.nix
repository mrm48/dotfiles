{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      nvim-jdtls
      mason-nvim
      mason-lspconfig-nvim
      nvim-treesitter.withAllGrammars
      telescope-nvim
      plenary-nvim
      nord-nvim
      lualine-nvim
      harpoon
      bufferline-nvim
      nvim-web-devicons
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
          highlight = {
            enable = true,
          },
        }

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

        require("mason").setup()
        require("mason-lspconfig").setup {
          automatic_installation = true,
        }

        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        vim.keymap.set('n', '<leader>a', mark.add_file)
        vim.keymap.set('n', '<leader>h', function() ui.nav_file(1) end)
        vim.keymap.set('n', '<leader>t', function() ui.nav_file(2) end)
        vim.keymap.set('n', '<leader>n', function() ui.nav_file(3) end)
        vim.keymap.set('n', '<leader>s', function() ui.nav_file(4) end)

        vim.keymap.set('n', '<leader>ha', ui.toggle_quick_menu)

        vim.g.nord_contrast = true
        vim.g.nord_borders = false
        vim.g.nord_disable_background = true
        vim.g.nord_italic = false
        vim.g.uniform_diff_background = false
        vim.g.nord_bold = false

        require('nord').set()

        vim.cmd[[colorscheme nord]]

        require('lualine').setup {
          options = {
            theme = 'nord'
          }
        }

        require('bufferline').setup{
          options = {
            mode = 'tabs'
          }
        }
    '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
