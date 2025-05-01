require('mini.deps').add({
    source = 'neovim/nvim-lspconfig',
    depends = {
        'folke/lazydev.nvim',
        'williamboman/mason.nvim',
        'nvim-telescope/telescope.nvim',
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
    }
})

require('mason').setup {}
require('lazydev').setup {}
require('mason-tool-installer').setup {}
require('mason-lspconfig').setup {
    automatic_installation = true,
    ensure_installed = {},
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup {}
        end,
    },
}
vim.diagnostic.config({ virtual_lines = { current_line = true } })
vim.keymap.set('n', '<leader>o', function()
    require('telescope.builtin').lsp_document_symbols(require('telescope.themes').get_dropdown {
        symbols = { 'function', 'method' },
        layout_config = {
            anchor = 'SE'
        }
    })
end)
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end

        if client:supports_method('textDocument/formatting') then
            vim.keymap.set('n', '<leader>f', function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
            end)
        end

        if client:supports_method('textDocument/codeaction') then
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
        end

        if client:supports_method('textDocument/rename') then
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
        end

        if client:supports_method('textDocument/definition') then
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
        end
    end,
})
