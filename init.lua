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
vim.opt.cursorline   = true
vim.opt.listchars    = { tab = '» ', trail = '·', nbsp = '␣' }
--vim.opt.cmdheight    = 0
vim.opt.path:append  "**"
vim.g.netrw_banner=0
vim.g.netrw_liststyle=3
vim.g.netrw_keepdir=0

require('plugin.colorscheme')
require('plugin.lsp')
require('plugin.telescope')
--require('plugin.treesitter')
require('plugin.dap')
require('plugin.git')
require('plugin.snippets')
require('plugin.statusline')

vim.cmd([[
"colorscheme catppuccin
command! -nargs=+ Grep execute 'silent grep! <args>' | copen
hi! link ComplMatchIns LspInlayHint
hi Normal guibg=NONE
hi NormalNC guibg=NONE
]])

vim.keymap.set('n' , '<leader>n'  , ":exe 'edit ~/notes/' . strftime('%Y-%m-%d') . '.md'<CR>" , { desc = "Open today's Note"                  })
vim.keymap.set('n' , '<leader>ee' , ':20Lex<CR>'                                      , { desc = 'Open explorer'                  })
vim.keymap.set('n' , '<leader>ef' , ':20Lex %:h<CR>'                                  , { desc = 'Open explorer'                  })
--vim.keymap.set('n' , '<leader>f'  , ':find '                                          , { desc = 'Find [f]iles'                   })
--vim.keymap.set('n' , '<leader>b'  , ':buffer '                                        , { desc = 'Open [b]uffers'                 })
--vim.keymap.set('n' , '<leader>gs' , ':Grep '                                          , { desc = 'Search [g]rep'                  })
vim.keymap.set('n' , '<Esc>'      , ':nohlsearch<CR>:cclose<CR>:lclose<CR>'           , {                                         })
vim.keymap.set('n' , '<M-j>'      , ':lnext<CR>'                                      , { desc = 'Jump to next loclist item'      })
vim.keymap.set('n' , '<M-k>'      , ':lprev<CR>'                                      , { desc = 'Jump to previous loclist item'  })
vim.keymap.set('n' , '<M-J>'      , ':cnext<CR>'                                      , { desc = 'Jump to next quickfix item'     })
vim.keymap.set('n' , '<M-K>'      , ':cprev<CR>'                                      , { desc = 'Jump to previous quickfix item' })
