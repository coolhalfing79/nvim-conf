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

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('lazy').setup({
    require('plugins.telescope'),
    require('plugins.treesitter'),
    require('plugins.bluloco'),
    require('plugins.fugitive'),
    require('plugins.jdtls'),
    require('plugins.cmp'),
    require('plugins.lsp'),
    require('plugins.oil'),
    require('plugins.indent-blankline'),
    {
        'nvim-tree/nvim-web-devicons',
        lazy = true,
        config = function()
            require 'nvim-web-devicons'.setup {
                default = true
            }
        end
    }
})

vim.wo.number = true
vim.wo.relativenumber = true
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.undofile = true
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.wo.signcolumn = 'yes'
vim.o.updatetime = 50
vim.o.timeoutlen = 150
vim.o.completeopt = 'menuone,preview'
vim.o.termguicolors = true
vim.g.netrw_banner = false
vim.g.netrw_altv = 1
vim.g.netrw_browse_split = 4
