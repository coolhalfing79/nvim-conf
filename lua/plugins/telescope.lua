local custom_preview = function(func, opts)
    local options = opts or {
        winblend = 10,
        previewer = false,
    }
    return function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        func(require('telescope.themes').get_dropdown(options))
    end
end

local goto_function = function(opts)
    local actions = require "telescope.actions"
    local action_state = require "telescope.actions.state"
    local pickers = require "telescope.pickers"
    local finders = require "telescope.finders"
    local conf = require("telescope.config").values
    opts = opts or {}
    local functions = require('nvim-treesitter.query').get_capture_matches(0,
        { '@definition.function', '@definition.method' }, 'locals') or {}
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
                vim.api.nvim_win_set_cursor(0, { row + 1, col + 1 })
                vim.cmd "norm! zz"
            end)
            return true
        end,
    }):find()
end

local M = {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        },
    },
    config = function()
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")
        telescope.setup({
            defaults = {
                layout_config = {
                    vertical = { width = 0.5 }
                }
            }
        })

        local nmap = require("plugins.utils").nmap
        pcall(require('telescope').load_extension, 'fzf')
        nmap('<leader>f', builtin.find_files, '[S]earch [F]iles')
        nmap('<leader>gf', builtin.git_files, 'Search [G]it [F]iles')
        nmap('<leader>sh', builtin.help_tags, '[S]earch [H]elp')
        nmap('<leader>sw', builtin.grep_string, '[S]earch current [W]ord')
        nmap('<leader>sg', builtin.live_grep, '[S]earch by [G]rep')
        nmap('<leader><space>', builtin.buffers, '[ ] Find existing buffers')
        nmap('<leader>/', custom_preview(builtin.current_buffer_fuzzy_find),
            '[/] Fuzzily search in current buffer')
        nmap('<leader>sd', custom_preview(builtin.diagnostics), '[S]earch [D]iagnostics')
        nmap('<leader>o', custom_preview(goto_function), '[S]how [F]unctions')
        nmap('gr', builtin.lsp_references, '[G]oto [R]eferences')
        nmap('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
        nmap('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    end
}

return M
