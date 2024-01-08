local M = {
  'tpope/vim-fugitive',
  config = function ()
      vim.keymap.set("n", "<leader>g", ":Git<CR>")
  end
}

return M
