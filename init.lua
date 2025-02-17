require("config.lazy")
vim.opt.relativenumber = false
vim.opt.number = true
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
vim.opt.jumpoptions = "stack"
------------------------------------------------------------------------------

require("config.dap")


-- Function to apply color to selected text in Visual mode
local function apply_color(color, range)
  -- Define ANSI color codes
  local colors = {
    red = "\027[31m",
    green = "\027[32m",
    yellow = "\027[33m",
    reset = "\027[0m"
  }

  -- Set the selected color code
  local color_code = colors[color] or colors["reset"]

  -- Get the lines in the selected range
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")

  -- Iterate over the lines in the selection
  for line_num = start_line, end_line do
    local line = vim.fn.getline(line_num)
    -- Find the start and end of the selected region in the current line
    local start_col = vim.fn.col("'<")
    local end_col = vim.fn.col("'>")

    -- Apply color to the selected region within the line
    local colored_line = line:sub(1, start_col - 1) .. color_code .. line:sub(start_col, end_col) .. colors.reset .. line:sub(end_col + 1)
    
    -- Replace the current line with the modified one
    vim.fn.setline(line_num, colored_line)
  end
end

-- Create ApplyRed, ApplyGreen, ApplyYellow commands that can be used with a range
vim.api.nvim_create_user_command('ApplyRed', function()
  -- Get the start and end positions from the visual selection range
  local range = { vim.fn.line("'<"), vim.fn.line("'>") }
  apply_color('red', range)
end, { range = true })

vim.api.nvim_create_user_command('ApplyGreen', function()
  -- Get the start and end positions from the visual selection range
  local range = { vim.fn.line("'<"), vim.fn.line("'>") }
  apply_color('green', range)
end, { range = true })

vim.api.nvim_create_user_command('ApplyYellow', function()
  -- Get the start and end positions from the visual selection range
  local range = { vim.fn.line("'<"), vim.fn.line("'>") }
  apply_color('yellow', range)
end, { range = true })

