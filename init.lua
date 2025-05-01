vim.g.mapleader      = ' '
vim.g.maplocalleader = ' '
vim.opt.number       = true
vim.opt.undofile     = true
vim.opt.updatetime   = 250
vim.opt.timeoutlen   = 300
vim.opt.inccommand   = 'split'
vim.opt.shiftwidth   = 4
vim.opt.expandtab    = true
vim.opt.completeopt  = 'menuone,noselect,popup'
vim.opt.cmdheight    = 0

require('plugin.mini')
require('plugin.lsp')
require('plugin.git')
require('plugin.telescope')
require('plugin.statusline')
require('mini.deps').add('rebelot/kanagawa.nvim')

vim.cmd.colorscheme('kanagawa')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<M-j>', ':cnext<CR>', { desc = 'Jump to next quickfix item' })
vim.keymap.set('n', '<M-k>', ':cprev<CR>', { desc = 'Jump to previous quickfix item' })
