local M = {
  'uloco/bluloco.nvim',
  lazy = false,
  priority = 1000,
  dependencies = { 'rktjmp/lush.nvim' },
  config = function()
      local bluloco = require('bluloco')
      bluloco.config.italics = true
      bluloco.config.transparent = true
  end,
}

return M
