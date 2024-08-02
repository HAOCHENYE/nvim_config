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


-- local cmp = require('cmp')
-- local config = cmp.get_config()

-- config.mapping['<Tab>'] = LazyVim.cmp.confirm({ select = true })
-- cmp.setup(config)
vim.g.lazyvim_python_lsp = "pyright"
-- Set to "ruff_lsp" to use the old LSP implementation version.
vim.g.lazyvim_python_ruff = "ruff"


--local cmp = require("cmp")
-- cmp.setup({auto_brackets={}})
require("config.dap")
