vim.pack.add({
    'https://github.com/L3MON4D3/LuaSnip.git',
    'https://github.com/rafamadriz/friendly-snippets.git'
})
require("luasnip.loaders.from_vscode").lazy_load()
