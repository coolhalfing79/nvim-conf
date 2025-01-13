-- Put this at the top of 'init.lua'
local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    -- Uncomment next line to use 'stable' branch
    -- '--branch', 'stable',
    'https://github.com/echasnovski/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.inccommand = 'split'
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

local MiniDeps = require('mini.deps')
MiniDeps.setup({ path = { package = path_package } })
MiniDeps.add('echasnovski/mini.statusline')

require('mini.statusline').setup()
require('plugins.telescope')
require('plugins.lsp')
require('plugins.cmp')
require('plugins.git')
require('plugins.colors')
