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
            }
        })
    end
}

return M
