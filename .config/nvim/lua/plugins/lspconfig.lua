return {
	'neovim/nvim-lspconfig',
	config = function()
        	require("lspconfig").jdtls.setup {}

        	require("lspconfig").gopls.setup {}

        	require("lspconfig").zls.setup {}
	end
}
