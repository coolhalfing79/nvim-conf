local MiniDeps = require('mini.deps')

MiniDeps.later(function()
    MiniDeps.add('ribru17/bamboo.nvim')
    vim.cmd.colorscheme('bamboo')
end)
