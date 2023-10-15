vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.wo.number = true
vim.wo.relativenumber = true
vim.g.netrw_banner = false
vim.o.cursorline = true
vim.o.smartindent = true

vim.o.splitright = true
vim.o.splitbelow = true
vim.o.completeopt = 'menuone,preview'
vim.o.termguicolors = true

vim.o.updatetime = 50
vim.o.timeoutlen = 300

vim.opt.undodir = vim.fn.stdpath('data') .. '/undo'
vim.o.undofile = true

vim.opt.path:append('**')

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
    {
        "Mofiqul/adwaita.nvim",
        lazy = false,
        priority = 1000,
    },
    'tpope/vim-fugitive',
    'judaew/ronny.nvim',
}, {})

vim.cmd.colorscheme 'adwaita'
local telescope_builtin = require 'telescope.builtin'

local nmap = function(keys, func)
    vim.keymap.set("n", keys, func)
end
local vmap = function(keys, func)
    vim.keymap.set("v", keys, func)
end

nmap("<leader>e", ":20Lex<CR>")
nmap("<leader>f", ":find ")
nmap("<leader>g", ":Git<CR>")
vmap("J", ":m '>+1<CR>gv=gv")
vmap("K", ":m '<-2<CR>gv=gv")
nmap("<leader>zf", telescope_builtin.find_files)
