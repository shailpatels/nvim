return {
    {
        "williamboman/mason.nvim",
        config = function()
            require('mason').setup()
        end
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim"
        },
        opts = {
            ensure_installed = { "pyright", "rust_analyzer", "zls", "intelephense", "clangd", "lua_ls" },
            automatic_enable = false,
        },
    },

    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require('lspconfig')
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local on_attach = function(client, bufnr)
                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
                vim.keymap.set('n', '<C-[>', vim.lsp.buf.references, bufopts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
                vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
                vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)

                vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, bufopts)

                vim.keymap.set({'n','v'}, '<space>ca', function()
                    vim.lsp.buf.code_action({}, bufnr)
                end, bufopts)

                vim.keymap.set({'n','v'}, '<space>f', function()
                    vim.lsp.buf.format({ async = true, bufnr = bufnr })
                end, bufopts)
            end

            lspconfig.pyright.setup({ on_attach = on_attach, capabilities = capabilities })
            lspconfig.intelephense.setup({ on_attach = on_attach, capabilities = capabilities  })
            lspconfig.clangd.setup({ on_attach = on_attach, capabilities = capabilities })
            lspconfig.lua_ls.setup({ on_attach = on_attach, capabilities = capabilities })

            lspconfig.gopls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                        },
                        staticcheck = true,
                        gofumpt = true,
                    },
                },
            })

            lspconfig.rust_analyzer.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        imports = {
                            granularity = {
                                group = "module",
                            },
                            prefix = "self",
                        },
                        cargo = {
                            buildScripts = {
                                enable = true,
                            },
                        },
                        procMacro = {
                            enable = true
                        },
                    }
                }
            })

            lspconfig.zls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    zls = {
                        zig_exe_path = (function()
                            local handle = io.popen('which zig 2> /dev/null')
                            if handle then
                                local result = handle:read("*a")
                                handle:close()
                                -- Remove trailing newline
                                return result:gsub("[\n\r]", "")
                            end
                            -- Fallback to a default path or return nil if which command fails
                            return nil
                        end)(),
                    }
                }
            })
        end,
    },

    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'L3MON4D3/LuaSnip',
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                }),
                sources = cmp.config.sources({
                    {name = 'nvim_lsp' },
                    {name = 'luasnip' },
                    {name = 'buffer' },
                    {name = 'path' },
                })
            })
        end,
    },
}
