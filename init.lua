vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.wo.number = true
vim.wo.relativenumber = true
vim.g.netrw_banner = false
vim.g.netrw_browser_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_liststyle = 0
vim.o.cursorline = true

vim.o.splitright = true
vim.o.splitbelow = true
vim.o.completeopt = 'menuone,preview'
vim.o.termguicolors = true

vim.o.updatetime = 50
vim.o.timeoutlen = 300

vim.opt.undodir = vim.fn.stdpath('data') .. '/undo'
vim.o.undofile = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.path:append('**')
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
        }
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'rafamadriz/friendly-snippets',
        },
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        },
    },
    { 'stevedylandev/flexoki-nvim', name = 'flexoki' },
    'judaew/ronny.nvim',
}, opts)

vim.cmd.colorscheme 'ronny'
require('mason').setup()
require('mason-lspconfig').setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
local telescope_builtin = require 'telescope.builtin'
local telescope_themes = require 'telescope.themes'

local nmap = function(keys, func)
    vim.keymap.set("n", keys, func)
end
local vmap = function(keys, func)
    vim.keymap.set("v", keys, func)
end

nmap("<leader>e", ":20Lex<CR>")
nmap("<leader>f", ":find ")
nmap("<leader>zf", telescope_builtin.find_files)
vmap("J", ":m '>+1<CR>gv=gv")
vmap("K", ":m '<-2<CR>gv=gv")

local symbols = function()
    return function()
        telescope_builtin.lsp_document_symbols(require('telescope.themes').get_dropdown({previewer = false}))
    end
end

local on_attach = function(_, bufnr)
    vim.notify('LSP attached', vim.log.levels.INFO)
    nmap('gd', vim.lsp.buf.definition)
    nmap('<C-a>', vim.lsp.buf.code_action)
    nmap('<C-]>', vim.lsp.buf.type_definition)
    nmap('K', vim.lsp.buf.hover)
    nmap('<C-k>', vim.lsp.buf.signature_help)
    nmap("<leader>o", symbols())
    nmap("<leader>d", telescope_builtin.diagnostics)

    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

lsps = {'rust_analyzer', 'gopls', 'lua_ls'}
local lspconfig = require('lspconfig')
for _, lsp in pairs(lsps) do
    lspconfig[lsp].setup {
        capabilities = capabilities,
        on_attach = on_attach,
    }
end
-- java is special
lspconfig['jdtls'].setup {
	capabilities = capabilities,
	on_attach = on_attach,
}
