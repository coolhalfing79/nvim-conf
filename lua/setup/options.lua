vim.cmd.colorscheme 'moonfly'
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.undofile = true
vim.o.hlsearch = false
vim.o.path="**"
vim.o.splitright = true
vim.o.splitbelow = true
-- vim.o.clipboard = 'unnamedplus'
vim.o.ignorecase = true
vim.wo.signcolumn = 'yes'
vim.o.updatetime = 150
vim.o.timeoutlen = 200
vim.o.completeopt = 'menuone,preview'
vim.o.termguicolors = true
vim.g.netrw_banner = false
vim.g.netrw_altv = 1
vim.g.netrw_browser_split = 4
vim.g.netrw_liststyle = 3
pcall(require('telescope').load_extension, 'fzf')
