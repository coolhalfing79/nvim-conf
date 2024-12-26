return {
  'tpope/vim-fugitive',
  config = function()
      vim.keymap.set('n', '<leader>gw', ':tab Git<CR>', { desc = '[G]it [W]indow' })
  end,
}
