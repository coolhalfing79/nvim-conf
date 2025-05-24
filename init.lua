vim.g.mapleader      = ' '
vim.g.maplocalleader = ' '
vim.opt.number       = true
vim.opt.undofile     = true
vim.opt.updatetime   = 200
vim.opt.timeoutlen   = 250
vim.opt.inccommand   = 'split'
vim.opt.shiftwidth   = 4
vim.opt.expandtab    = true
vim.opt.completeopt  = 'menuone,noselect,popup'
vim.opt.cmdheight    = 0
vim.o.winborder      = 'single'
vim.o.signcolumn     = 'yes'
vim.o.list           = true
vim.opt.listchars    = { tab = '» ', trail = '·', nbsp = '␣' }

require('plugin.mini')
require('plugin.lsp')
require('plugin.git')
require('plugin.telescope')
vim.cmd.colorscheme('habamax')
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
