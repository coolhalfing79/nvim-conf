vim.pack.add({
    'https://github.com/mfussenegger/nvim-dap',
}, { load = true })

local dap  = require('dap')
local function execute_command(params, callback)
    -- 1. Find the active JDTLS client
    -- Note: Use vim.lsp.get_clients() for Neovim 0.10+, or vim.lsp.get_active_clients() for older versions
    local clients = vim.lsp.get_clients({ name = 'jdtls' })
    local client = clients[1]

    if not client then
        vim.notify("JDTLS client not found. Make sure a Java file is open.", vim.log.levels.ERROR)
        return
    end

    -- 2. Send the workspace/executeCommand request
    client:request('workspace/executeCommand', params, function(err, result, ctx)
        vim.print(ctx)
        callback(err, result)
    end, 0) -- 0 indicates the current buffer
end
dap.adapters.java = function(callback)
    execute_command({ command = 'vscode.java.startDebugSession' }, function(err, port)
        if err then
            vim.notify("Failed to start debug session: " .. vim.inspect(err), vim.log.levels.ERROR)
            return
        end
        -- The JDTLS server returns the port where the Debug Adapter is listening
        callback({
            type = 'server',
            host = '127.0.0.1',
            port = port
        })
    end)
end
-- dap.configurations.java = {
--   {
--     type = 'java',  -- Must match the key in dap.adapters
--     request = 'attach',
--     name = "Debug (Attach) - Remote",
--     hostName = "localhost",
--     port = 7777,  -- Must match the port your remote process is listening on
--   },
-- }

vim.keymap.set('n', '<leader>ta', dap.up)
vim.keymap.set('n', '<leader>tb', dap.toggle_breakpoint)
vim.keymap.set('n', '<F6>'      , dap.continue)
vim.keymap.set('n', '<F10>'     , dap.step_out)
vim.keymap.set('n', '<F11>'     , dap.step_into)
vim.keymap.set('n', 'S-<F11>'   , dap.step_out)
