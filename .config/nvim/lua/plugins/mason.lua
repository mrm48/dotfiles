return {
	'williamboman/mason.nvim',
    config = function()
        require('mason').setup{}
    	-- Set up lspconfig.
    	local capabilities = require('cmp_nvim_lsp').default_capabilities()
    	require('lspconfig')['jdtls'].setup {
    	  capabilities = capabilities
    	}

        require('lspconfig')['gopls'].setup {
            capabilities = capabilities
        }
    end
}
