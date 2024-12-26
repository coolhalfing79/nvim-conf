return {
    'neovim/nvim-lspconfig',
    dependencies = {
        { 'williamboman/mason.nvim',                  config = true }, -- NOTE: Must be loaded before dependants
        { 'williamboman/mason-lspconfig.nvim' },
        { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
        { 'folke/lazydev.nvim',                       opts = {} },
        { 'nvim-telescope/telescope.nvim' },
        { 'saghen/blink.cmp' },
    },
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)
        vim.keymap.set('n', '<leader>o', function()
            builtin.lsp_document_symbols(require('telescope.themes').get_dropdown {
                symbols = { 'function', 'method' },
                layout_config = {
                    anchor = 'SE'
                }
            })
        end, { desc = '[ ] Functions in current buffer' })

        require('mason').setup()
        require('mason-tool-installer').setup {}

        local servers = {}
        require('mason-lspconfig').setup {
            automatic_installation = true,
            ensure_installed = {},
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    local capabilities = vim.lsp.protocol.make_client_capabilities()
                    capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
                    server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                    require('lspconfig')[server_name].setup(server)
                end,
            },
        }
    end
}
