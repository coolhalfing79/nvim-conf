local MiniDeps = require('mini.deps')

MiniDeps.later(function ()
    MiniDeps.add('tpope/vim-fugitive')
    vim.keymap.set('n', '<leader>gw', ':tab Git<CR>', { desc = '[G]it [W]indow' })
end)
