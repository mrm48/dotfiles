return {
    	'ThePrimeagen/harpoon',
    	branch = 'harpoon2',
    	requires = { {'nvim-lua/plenary.nvim'} },
	config = function()
        	local harpoon = require("harpoon")

        	vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end)
        	vim.keymap.set('n', '<leader>h', function() harpoon:list():select(1) end)
        	vim.keymap.set('n', '<leader>j', function() harpoon:list():select(2) end)
        	vim.keymap.set('n', '<leader>k', function() harpoon:list():select(3) end)
        	vim.keymap.set('n', '<leader>l', function() harpoon:list():select(4) end)

        	vim.keymap.set('n', '<leader>n', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
	end
}
