vim.g.mapleader      = ' '
vim.g.maplocalleader = ' '
vim.opt.number       = true
vim.opt.undofile     = true
vim.opt.updatetime   = 200
vim.opt.timeoutlen   = 250
vim.opt.inccommand   = 'split'
vim.opt.shiftwidth   = 4
vim.opt.expandtab    = true
vim.opt.completeopt  = 'menuone,noselect,preinsert'
vim.opt.showmode     = false
vim.opt.winborder    = 'shadow'
vim.opt.signcolumn   = 'yes'
vim.opt.list         = true
vim.opt.listchars    = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.path:append  "**"

vim.cmd([[
command! -nargs=+ Grep execute 'silent grep! <args>' | copen
hi! link ComplMatchIns LspInlayHint
]])

require('plugin.lsp')
require('plugin.git')
require('plugin.snippets')
require('plugin.statusline')

vim.keymap.set('n' , '<leader>e'  , ':20Lex<CR>'                            , { desc = 'Open explorer'                  })
vim.keymap.set('n' , '<leader>f'  , ':find '                                , { desc = 'Find [f]iles'                   })
vim.keymap.set('n' , '<leader>b'  , ':buffers<CR>:buffer '                  , { desc = 'Open [b]uffers'                 })
vim.keymap.set('n' , '<leader>gs' , ':Grep '                                , { desc = 'Search [g]rep'                  })
vim.keymap.set('n' , '<Esc>'      , ':nohlsearch<CR>:cclose<CR>:lclose<CR>' , {                                         })
vim.keymap.set('n' , '<M-j>'      , ':lnext<CR>'                            , { desc = 'Jump to next loclist item'      })
vim.keymap.set('n' , '<M-k>'      , ':lprev<CR>'                            , { desc = 'Jump to previous loclist item'  })
vim.keymap.set('n' , '<M-J>'      , ':cnext<CR>'                            , { desc = 'Jump to next quickfix item'     })
vim.keymap.set('n' , '<M-K>'      , ':cprev<CR>'                            , { desc = 'Jump to previous quickfix item' })
