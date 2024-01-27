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
      gruvbox-nvim
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

        require("gruvbox").setup({
            terminal_colors = true, -- add neovim terminal colors
            undercurl = true,
            underline = true,
            bold = true,
            italic = {
              strings = true,
              emphasis = true,
              comments = true,
              operators = false,
              folds = true,
            },
            strikethrough = true,
            invert_selection = false,
            invert_signs = false,
            invert_tabline = false,
            invert_intend_guides = false,
            inverse = true, -- invert background for search, diffs, statuslines and errors
            contrast = "", -- can be "hard", "soft" or empty string
            palette_overrides = {},
            overrides = {},
            dim_inactive = false,
            transparent_mode = false,
        })
        vim.cmd("colorscheme gruvbox")

        require('lualine').setup {
          options = {
            theme = 'gruvbox'
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
