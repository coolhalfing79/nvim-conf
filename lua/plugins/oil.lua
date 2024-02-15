local M = {
    'stevearc/oil.nvim',
    config = function()
        local oil = require("oil")
        oil.setup({
            columns = {
                "icon",
                "permissions",
                "size",
                "mtime",
            },
            keymaps = {
                ["-"] = "actions.parent",
            },
        })
        local nmap = require("plugins.utils").nmap
        nmap('<leader>e', oil.open, '[E]xplorer')
    end
}

return M
