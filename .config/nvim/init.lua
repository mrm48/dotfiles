vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {   "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { {"nvim-lua/plenary.nvim"} }
    },
	"nvim-telescope/telescope.nvim",
	"mfussenegger/nvim-jdtls",
	"williamboman/mason.nvim",
	"neovim/nvim-lspconfig",
	"williamboman/mason-lspconfig.nvim",
	"hrsh7th/nvim-cmp",
	"nvim-lua/plenary.nvim",
	"hrsh7th/cmp-nvim-lsp",
	"nvim-tree/nvim-web-devicons",
	"akinsho/bufferline.nvim",
	"nvim-lualine/lualine.nvim",
	"nvim-treesitter/nvim-treesitter",
   	"ellisonleao/gruvbox.nvim",
 	"hrsh7th/vim-vsnip",
    "tpope/vim-fugitive",
    "lewis6991/gitsigns.nvim",
    "rebelot/kanagawa.nvim",
    "craftzdog/solarized-osaka.nvim",
    "folke/tokyonight.nvim",
    "catppuccin/nvim",
})

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

        require("lspconfig").zls.setup {}

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

        local harpoon = require("harpoon")

        vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end)
        vim.keymap.set('n', '<leader>h', function() harpoon:list():select(1) end)
        vim.keymap.set('n', '<leader>j', function() harpoon:list():select(2) end)
        vim.keymap.set('n', '<leader>k', function() harpoon:list():select(3) end)
        vim.keymap.set('n', '<leader>l', function() harpoon:list():select(4) end)

        vim.keymap.set('n', '<leader>n', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        require("matt")
        
        vim.opt.termguicolors = true
        
        require('bufferline').setup{
          options = {
            mode = 'tabs'
          }
        }

        require('lualine').setup {
          options = {
            theme = 'auto'
          }
        }

        require('gitsigns').setup()

        vim.keymap.set('n', '<leader>gb', ':Gitsigns toggle_current_line_blame<CR>')
        vim.keymap.set('n', '<leader>gp', ':Gitsigns preview_hunk<CR>')


