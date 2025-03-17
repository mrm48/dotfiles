return {
    'nvim-treesitter/nvim-treesitter',
    config = function() 
       local parser_install_dir = vim.fn.stdpath("cache") .. "/treesitters"
        vim.fn.mkdir(parser_install_dir, "p")
        -- Prevents reinstall of treesitter plugins every boot
        vim.opt.runtimepath:append(parser_install_dir)

        require'nvim-treesitter.configs'.setup {
          highlight = {
            enable = true,
          },
        }
    end,
}
