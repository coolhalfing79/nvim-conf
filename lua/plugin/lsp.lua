vim.pack.add({
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/folke/lazydev.nvim',
}, { load = true })

require('lazydev').setup {}

vim.lsp.enable({'lua_ls', 'jdtls', 'gopls'})
vim.lsp.config('jdtls', {
    root_markers = {'.git'}
})

vim.diagnostic.config({ virtual_lines = { current_line = true } })
vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        if client:supports_method('textDocument/documentSymbol') then
            vim.keymap.set('n', '<leader>s', function()
                vim.lsp.buf.document_symbol({
                    loclist = true,
                    on_list = function(options)
                        options.items = vim.tbl_filter(function(item)
                            return item.kind == 'Method' or item.kind == 'Function'
                        end, options.items)
                        vim.fn.setloclist(0, {}, " ", options)
                        vim.cmd.lopen()
                    end
                })
            end)
        end

        if client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_user_command('Format', function()
                vim.lsp.buf.format()
            end, {})
        end

        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end

        if client:supports_method('textDocument/codeAction') then
            vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action)
        end

        if client:supports_method('textDocument/implementation') then
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
        end

        if client:supports_method('textDocument/definition') then
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
        end
    end,
})
