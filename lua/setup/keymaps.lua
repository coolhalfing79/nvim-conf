local custom_preview = function(func, opts)
    local opts = opts or {
            winblend = 10,
            previewer = false,
        }
    return function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        func(require('telescope.themes').get_dropdown(opts))
    end
end

local goto_function = function(opts)
    local actions = require "telescope.actions"
    local action_state = require "telescope.actions.state"
    local pickers = require "telescope.pickers"
    local finders = require "telescope.finders"
    local conf = require("telescope.config").values
    opts = opts or {}
    local functions = require('nvim-treesitter.query').get_capture_matches(0, {'@definition.function', '@definition.method'}, 'locals')
    local fns = {}
    for _, entry in ipairs(functions) do
        table.insert(fns, {
            node = entry.node,
            text = vim.treesitter.get_node_text(entry.node, 0)
        })
    end
    -- our picker function: colors
    pickers.new(opts, {
        prompt_title = "Goto Function",
        finder = finders.new_table {
            results = fns,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = "Function: " .. entry.text,
                    ordinal = entry.text,
                }
            end,
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if not selection then
                    return
                end
                -- print(vim.inspect(selection))
                local row, col, _ = vim.treesitter.get_node_range(selection.value.node)
                print(vim.inspect(row))
                vim.api.nvim_win_set_cursor(0, {row+1, col+1})
                vim.cmd "norm! zz"
            end)
            return true
        end,
    }):find()
end
vim.keymap.set('n', '<leader>f', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', custom_preview(require('telescope.builtin').current_buffer_fuzzy_find), { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>sd', custom_preview(require('telescope.builtin').diagnostics), { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>o', custom_preview(goto_function), { desc = '[S]how [F]unctions' })
