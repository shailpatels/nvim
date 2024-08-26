return {
	{
		{
			"williamboman/mason.nvim",
			config = function()
				require('mason').setup()
			end
		},

		{
			"williamboman/mason-lspconfig.nvim",
			config = function()
				require('mason-lspconfig').setup({
					ensure_installed = { "pyright", "tsserver", "rust_analyzer" },
				})
			end,
		},

		{
			"neovim/nvim-lspconfig",
			config = function()
				local lspconfig = require('lspconfig')
				local on_attach = function(client, bufnr)
					local bufopts = { noremap = true, silent = true, buffer = bufnr }
					vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
					vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
					vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
					vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
					vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
					vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
					vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
				end

				lspconfig.pyright.setup({ on_attach = on_attach })
				lspconfig.tsserver.setup({ on_attach = on_attach })
				lspconfig.zls.setup({ 
                    on_attach = on_attach,
                    settings = {
                        zls = {
                            zig_exe_path = "/home/shail/GitHub/zig/build/stage3/bin/zig",
                        }
                    }
                })
			end,
		},

		{
			'hrsh7th/nvim-cmp',
			config = function()
				local cmp = require('cmp')
				cmp.setup({
					snippet = {
						expand = function(args)
							require('luasnip').lsp_expand(args.body)
						end,
					},
					mapping = cmp.mapping.preset.insert({
						['<C-b>'] = cmp.mapping.scroll_docs(-4),
						['<C-f>'] = cmp.mapping.scroll_docs(4),
						['<C-Space>'] = cmp.mapping.complete(),
						['<C-e>'] = cmp.mapping.abort(),
						['<CR>'] = cmp.mapping.confirm({ select = true }),
					}),
					sources = cmp.config.sources({
						{ name = 'nvim_lsp' },
					}, {
						{ name = 'buffer' },
					})
				})
			end,
		},

		'hrsh7th/cmp-nvim-lsp',
		'L3MON4D3/LuaSnip',
	}

}
