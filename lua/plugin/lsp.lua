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
            vim.lsp.enable(server_name)
        end,
    },
}
vim.diagnostic.config({ virtual_lines = { current_line = true } })
vim.keymap.set('n', '<leader>s', function()
    require('telescope.builtin').lsp_document_symbols({
        symbols = { 'function', 'method' },
    })
end)
vim.api.nvim_create_user_command('Format', function()
    vim.lsp.buf.format()
end, {})
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end

        if client:supports_method('textDocument/codeAction') then
            vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action)
        end

        if client:supports_method('textDocument/rename') then
            vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename)
        end

        if client:supports_method('textDocument/implementation') then
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
        end

        if client:supports_method('textDocument/definition') then
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
        end
    end,
})
