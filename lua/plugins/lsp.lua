local Minideps = require('mini.deps')
local add = Minideps.add

add({
    source = 'neovim/nvim-lspconfig',
    depends = {
        'folke/lazydev.nvim',
        'hrsh7th/cmp-nvim-lsp',
        'williamboman/mason.nvim',
        'nvim-telescope/telescope.nvim',
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
    }
})
require('lazydev').setup()
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
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
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
        end,
    },
}
