vim.pack.add({
    'https://github.com/nvim-treesitter/nvim-treesitter',
}, { load = true })

require('telescope').setup {
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "java", "gradle" },
}
