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
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      nvim-treesitter.withPlugins (p: [ p.java p.golang ])
      telescope-nvim
      plenary-nvim
      nord-nvim
      kanagawa-nvim
      gruvbox-nvim
      lualine-nvim
      harpoon
      bufferline-nvim
      nvim-web-devicons
    ];
    extraConfig = ''
      luafile /home/matt/.dotfiles/modules/neovim/globalopts.lua
      luafile /home/matt/.dotfiles/modules/neovim/set.lua
      luafile /home/matt/.dotfiles/modules/neovim/lsp.lua
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

        require("lspconfig").jdtls.setup {}
        require("lspconfig").gopls.setup {}

        -- Set up nvim-cmp.
        local cmp = require'cmp'
      
        cmp.setup({
          snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
              vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
              -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
              -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
              -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            end,
          },
          window = {
            -- completion = cmp.config.window.bordered(),
            -- documentation = cmp.config.window.bordered(),
          },
          mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          }),
          sources = cmp.config.sources({
            { name = 'nvim_lsp' },
          }, {
            { name = 'buffer' },
          })
        })
      
        -- Set configuration for specific filetype.
        cmp.setup.filetype('gitcommit', {
          sources = cmp.config.sources({
            { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
          }, {
            { name = 'buffer' },
          })
        })
      
        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = 'buffer' }
          }
        })
      
        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = 'path' }
          }, {
            { name = 'cmdline' }
          })
        })
      
        -- Set up lspconfig.
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        require('lspconfig')['jdtls'].setup {
          capabilities = capabilities
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
        require('kanagawa').setup({
          compile = false,             -- enable compiling the colorscheme
          undercurl = true,            -- enable undercurls
          commentStyle = { italic = true },
          functionStyle = {},
          keywordStyle = { italic = true},
          statementStyle = { bold = true },
          typeStyle = {},
          transparent = true,         -- do not set background color
          dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
          terminalColors = true,       -- define vim.g.terminal_color_{0,17}
          colors = {                   -- add/modify theme and palette colors
              palette = {},
              theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
          },
          overrides = function(colors) -- add/modify highlights
              return {}
          end,
          theme = "wave",              -- Load "wave" theme when 'background' option is not set
          background = {               -- map the value of 'background' option to a theme
              dark = "wave",           -- try "dragon" !
              light = "lotus"
          },
        })
        vim.cmd("colorscheme kanagawa")

        require('lualine').setup {
          options = {
            theme = 'auto'
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
