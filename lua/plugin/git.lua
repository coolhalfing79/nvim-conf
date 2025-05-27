vim.pack.add({'https://github.com/tpope/vim-fugitive'}, { load = true })
vim.keymap.set('n', '<leader>gw', ':tab Git<CR>', { desc = '[G]it [W]indow' })
