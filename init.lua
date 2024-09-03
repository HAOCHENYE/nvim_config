require("config.lazy")
vim.opt.relativenumber = false
-- vim.opt.mouse = ""

------------------------------------------------------------------------------
vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}
------------------------------------------------------------------------------
-- 使用空格代替 Tab
vim.opt.expandtab = true

-- 每次 Tab 键插入的空格数
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- 自动缩进时使用的空格数
vim.opt.softtabstop = 4
------------------------------------------------------------------------------

require("config.dap")
