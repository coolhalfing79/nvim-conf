vim.pack.add({
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
    { src = 'https://github.com/nvim-telescope/telescope.nvim', version = 'v0.2.0' },
    'https://github.com/nvim-telescope/telescope-ui-select.nvim',
    'https://github.com/nvim-tree/nvim-web-devicons'
}, { load = true })

require('telescope').setup {
    --extensions = {
    --    ['ui-select'] = {
    --        require('telescope.themes').get_dropdown(),
    --    },
    --},
    --defaults = {
    --    -- layout_strategy = 'bottom_pane',
    --}
}

-- Enable Telescope extensions if they are installed
pcall(require('telescope').load_extension, 'fzf')
-- pcall(require('telescope').load_extension, 'ui-select')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>h', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>w', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>g', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>d', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>r', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer' })
