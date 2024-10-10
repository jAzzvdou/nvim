return {
    'neovim/nvim-lspconfig',
    dependencies = {
        {
            'williamboman/mason.nvim',
            opts = {},
        },
        'williamboman/mason-lspconfig.nvim',
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
        -- Extend LSP capabilities with nvim cmp
        local capabilities = vim.lsp.protocol.make_client_capabilities()

        local servers = {
            pylsp = {},
            lua_ls = {
                settings = {
                    Lua = {
                        -- Disable the global variable 'vim' warning
                        diagnostics = { globals = { 'vim' } },
                    },
                },
            },
        }

        require('mason').setup()

        local lspconfig = require('lspconfig')

        require('mason-lspconfig').setup({
            ensure_installed = vim.tbl_keys(servers or {}),
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}

                    -- This handles overriding only values explicitly passed
                    -- by the server configuration above
                    server.capabilities = vim.tbl_deep_extend('force', {}, capabilities,
                        server.capabilities or {})
                    lspconfig[server_name].setup(server)
                end,
            },
        })
    end,
}
