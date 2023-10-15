require('mason').setup()
require('mason-lspconfig').setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
local telescope_builtin = require 'telescope.builtin'

local symbols = function()
    return function()
        telescope_builtin.lsp_document_symbols(require('telescope.themes').get_dropdown({previewer = false}))
    end
end

local nmap = function(keys, func)
    vim.keymap.set("n", keys, func)
end
local on_attach = function(_, bufnr)
    vim.notify('LSP attached', vim.log.levels.INFO)
    nmap('gd', vim.lsp.buf.definition)
    nmap('<C-a>', vim.lsp.buf.code_action)
    nmap('<C-]>', vim.lsp.buf.type_definition)
    nmap('K', vim.lsp.buf.hover)
    nmap('<C-k>', vim.lsp.buf.signature_help)
    nmap("<leader>o", symbols())
    nmap("<leader>d", vim.diagnostic.setloclist)

    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

lsps = {'rust_analyzer', 'jdtls', 'gopls', 'lua_ls'}
local lspconfig = require('lspconfig')
for _, lsp in pairs(lsps) do
    lspconfig[lsp].setup {
        capabilities = capabilities,
        on_attach = on_attach,
    }
end
