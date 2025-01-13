local MiniDeps = require('mini.deps')

MiniDeps.later(function ()
    MiniDeps.add({
        source = 'nvim-treesitter/nvim-treesitter',
        -- Use 'master' while monitoring updates in 'main'
        checkout = 'master',
        monitor = 'main',
        -- Perform action after every checkout
        hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
    })

    require('nvim-treesitter.configs').setup({
        ensure_installed = { 'lua', 'vimdoc' },
        highlight = { enable = true },
        modules = {},
        sync_install = false,
        auto_install = true,
        ignore_install = {}
    })
end)
