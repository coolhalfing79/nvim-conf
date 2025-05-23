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
require('plugin.statusline')
require('mini.deps').add('rebelot/kanagawa.nvim')

require('kanagawa').setup({
    transparent = true, -- do not set background color
    overrides = function(colors)
        local theme = colors.theme
        return {
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },

            -- Save an hlgroup with dark background and dimmed foreground
            -- so that you can use it where your still want darker windows.
            -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

            -- Popular plugins that open floats will link to NormalFloat by default;
            -- set their background accordingly if you wish to keep them dark and borderless
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        }
    end,
})
vim.cmd.colorscheme('kanagawa')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<M-j>', ':cnext<CR>', { desc = 'Jump to next quickfix item' })
vim.keymap.set('n', '<M-k>', ':cprev<CR>', { desc = 'Jump to previous quickfix item' })
