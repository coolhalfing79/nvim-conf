vim.g.mapleader      = ' '
vim.g.maplocalleader = ' '

vim.o.number         = true
vim.o.undofile       = true
vim.o.updatetime     = 250
vim.o.timeoutlen     = 300
vim.o.inccommand     = 'split'
vim.o.shiftwidth     = 4
vim.o.expandtab      = true
vim.o.completeopt    = 'menuone,noselect,popup'
vim.o.cmdheight      = 0
vim.o.winborder      = 'single'
vim.o.signcolumn     = 'yes'
vim.o.list           = true

vim.opt.listchars    = { tab = '» ', trail = '·', nbsp = '␣' }

require('plugin.mini')
require('plugin.lsp')
require('plugin.git')
require('plugin.telescope')
local MiniDeps = require('mini.deps')
MiniDeps.add('bluz71/vim-moonfly-colors')
vim.cmd.colorscheme('moonfly')
vim.cmd([[
hi! link TelescopePreviewNormal Pmenu
hi! link TelescopePromptNormal Pmenu
hi! link TelescopeResultsNormal Pmenu
hi! link FloatBorder Pmenu
hi Normal guibg=none
]])
require('plugin.statusline')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<M-j>', ':cnext<CR>', { desc = 'Jump to next quickfix item' })
vim.keymap.set('n', '<M-k>', ':cprev<CR>', { desc = 'Jump to previous quickfix item' })
