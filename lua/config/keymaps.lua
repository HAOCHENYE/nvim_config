-- -- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- 将选定内容复制到系统剪贴板
vim.api.nvim_set_keymap('v', 'Y', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'Y', '"+y', { noremap = true, silent = true })
-- 在普通模式下按 Ctrl+a 全选
vim.api.nvim_set_keymap('n', '<C-a>', 'gg0vG$', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'wdt', '<cmd>windo diffthis<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'wdo', '<cmd>windo diffoff<cr>', { noremap = true, silent = true })


local function copy_file_path_to_clipboard()
  local file_path = vim.fn.expand('%:p')
  vim.fn.setreg('+', file_path)
  print("File path copied to clipboard: " .. file_path)
end

vim.keymap.set("n", "<leader>cp", copy_file_path_to_clipboard)

local function copy_file_name_to_clipboard()
  local file_path = vim.fn.expand('%:t')
  vim.fn.setreg('+', file_path)
  print("File filename copied to clipboard: " .. file_path)
end
vim.keymap.set("n", "<leader>cP", copy_file_name_to_clipboard)

local function toggle_neotree()
 vim.cmd('Neotree show')
end

-- vim.keymap.set('n', '<leader>to', '<cmd>Neotree show<CR>')
-- vim.keymap.set('n', '<leader>tq', '<cmd>Neotree close<CR>')
vim.keymap.set("n", "<leader>cp", copy_file_path_to_clipboard)


-- 检查当前是否在差异模式
local function is_diff_mode()
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.api.nvim_win_get_option(win, 'diff') then
            return true
        end
    end
    return false
end

-- 定义切换差异模式的函数
local function toggle_diff_mode()
    if is_diff_mode() then
        vim.cmd('windo diffoff')
    else
        vim.cmd('windo diffthis')
    end
end

-- vim.keymap.set("n", "<leader>wd", toggle_diff_mode)

-- 将 <leader>bd 映射为关闭当前 buffer 而不关闭窗口
vim.api.nvim_set_keymap('n', '<leader>bd', ':b# | bd #<CR>', { noremap = true, silent = true })


-- Fzflua 相关的配置
vim.api.nvim_set_keymap('n', '<leader>fv', '<cmd>FzfLua grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>FzfLua oldfiles<CR>', { noremap = true, silent = true })

-------------------------------- 把 buffer 移动到左边窗口 ------------------------------
local function move_buffer_to_left_window()
  -- 获取当前缓冲区和窗口ID
  local current_buffer = vim.fn.bufnr('%')
  local previous_buffer = vim.fn.bufnr('#')
  local current_window = vim.fn.winnr()
  vim.cmd('buffer ' .. previous_buffer)

  -- 切换到左边的窗口，如果没有则创建
  if vim.fn.winnr('h') == current_window then
    vim.cmd('vsplit')
  else
    vim.cmd('wincmd h')
  end
  -- 获取左边窗口的缓冲区ID

  local left_buffer = vim.fn.bufnr('%')

  -- 在左边窗口显示当前缓冲区
  vim.cmd('buffer ' .. current_buffer)
  
  -- 切换回原窗口并显示之前的缓冲区
  vim.cmd(current_window .. 'wincmd w')
  vim.cmd('buffer ' .. left_buffer)
end

local function move_buffer_to_right_window()
  -- 获取当前缓冲区和窗口ID
  local current_buffer = vim.fn.bufnr('%')
  local previous_buffer = vim.fn.bufnr('#')
  local current_window = vim.fn.winnr()
  vim.cmd('buffer ' .. previous_buffer)
  -- 切换到左边的窗口，如果没有则创建
  if vim.fn.winnr('l') == current_window then
    vim.cmd('vsplit')
  else
    vim.cmd('wincmd l')
  end

  -- 获取左边窗口的缓冲区ID
  local right_buffer = vim.fn.bufnr('%')

  -- 在左边窗口显示当前缓冲区
  vim.cmd('buffer ' .. current_buffer)

  -- 切换回原窗口并显示之前的缓冲区
  vim.cmd(current_window .. 'wincmd w')
  vim.cmd('buffer ' .. right_buffer)
end

vim.keymap.set("n", "<leader>mbl", move_buffer_to_left_window)
vim.keymap.set("n", "<leader>mbr", move_buffer_to_right_window)
-------------------------------- 把 buffer 移动到左边窗口 ------------------------------

-- vim.keymap.set('v', '<Tab>', '>gv')
-- vim.keymap.set('v', '<S-Tab>', '<gv')
-- vim.keymap.set('n', '<Tab>', '>>')
-- vim.keymap.set('n', '<S-Tab>', '<<')

--------------------------------------------------------
-- 解绑 <Alt-j> 快捷键
local opts = { noremap = true, silent = true }
vim.api.nvim_del_keymap('n', '<A-j>')  -- 正常模式
vim.api.nvim_del_keymap('v', '<A-j>')  -- 可视模式
vim.api.nvim_del_keymap('n', '<A-k>')  -- 正常模式
vim.api.nvim_del_keymap('v', '<A-k>')  -- 可视模式



vim.api.nvim_set_keymap('v', '<C-k>', ":m '<-2<CR>gv=gv", opts)
vim.api.nvim_set_keymap('n', '<C-k>', "<cmd>m .-2<CR>==", opts)
 
vim.api.nvim_set_keymap('v', '<C-j>', ":m '>+1<CR>gv=gv", opts)
vim.api.nvim_set_keymap('n', '<C-j>', "<cmd>m .+1<CR>==", opts)



--------------------------------------------------------
-- 重新绑定 C-o 到 Alt-h
-- vim.api.nvim_set_keymap('n', '<A-h>', '<C-o>', { noremap = true, silent = true })
-- 重新绑定 C-i 到 Alt-l
-- vim.api.nvim_set_keymap('n', '<A-l>', '<C-i>', { noremap = true, silent = true })
--------------------------------------------------------
vim.keymap.del('n', '<C-/>')
vim.keymap.del('n', '<C-_>')
vim.keymap.del('n', '<leader>wd')  -- 关闭 leader wd 关闭 window 的功能
vim.keymap.del('n', '<leader>ft')
vim.keymap.set('n', '<C-/>', '<cmd>ToggleTerm size=25<CR>')
vim.keymap.set('n', '<C-_>', '<cmd>ToggleTerm size=25<CR>')
--------------------------------------------------------
local function switch_to_previous_buffer()
  -- Get the name of the previous buffer
  local prev_bufname = vim.fn.bufname('#')

  -- Check if the previous buffer is valid
  if prev_bufname ~= '' then
    -- Execute the buffer switch
    vim.cmd('b#')

    -- Reload the buffer to ensure it is in the buffer list
    vim.cmd('edit ' .. prev_bufname)
  else
    print("No previous buffer to switch to.")
  end
end

vim.keymap.set('n', '<leader>b#', switch_to_previous_buffer, { noremap = true, silent = true, desc="Reopen the closed buffer" })
--------------------------------------------------------
local function DiffFormat()

  local ignore_filetypes = { "lua" }
  if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
    vim.notify("range formatting for " .. vim.bo.filetype .. " not working properly.")
    return
  end

  local hunks = require("gitsigns").get_hunks()
  if hunks == nil then
    return
  end

  local format = require("conform").format

  local function format_range()
    if next(hunks) == nil then
      vim.notify("done formatting git hunks", "info", { title = "formatting" })
      return
    end
    local hunk = nil
    while next(hunks) ~= nil and (hunk == nil or hunk.type == "delete") do
      hunk = table.remove(hunks)
    end

    if hunk ~= nil and hunk.type ~= "delete" then
      local start = hunk.added.start
      local last = start + hunk.added.count
      -- nvim_buf_get_lines uses zero-based indexing -> subtract from last
      local last_hunk_line = vim.api.nvim_buf_get_lines(0, last - 2, last - 1, true)[1]
      local range = { start = { start, 0 }, ["end"] = { last - 1, last_hunk_line:len() } }
      format({ range = range, async = true, lsp_fallback = true }, function()
        vim.defer_fn(function()
          format_range()
        end, 1)
      end)
    end
  end

  format_range()
end

local function Format()
  local conform = require('conform')
  conform.format()
end

vim.api.nvim_create_user_command('DiffFormat', DiffFormat, { nargs = 0, desc = "Diff Format Current File"})
vim.api.nvim_create_user_command('Format', Format, { nargs = 0, desc = "Format Current File"})


local function toggle_wrap()
    if vim.wo.wrap then
        vim.wo.wrap = false
    else
        vim.wo.wrap = true
    end
end

vim.keymap.set('n', '<A-z>', toggle_wrap)
vim.keymap.set('n', '<leader>tf', "<cmd>tabnext<CR>")
vim.keymap.set('n', '<leader>tb', "<cmd>tabprevious<CR>")
vim.keymap.set('n', '<leader>tc', "<cmd>tabclose<CR>")
vim.keymap.set('n', '<leader>tn', "<cmd>tabnew<CR>")

-- 在你的 init.lua 或相关配置文件中添加以下内容
vim.api.nvim_set_keymap('v', '<leader>ss', [[:lua SearchInVisualSelection()<CR>]], { noremap = true, silent = true })

-- 定义 SearchInVisualSelection 函数
function SearchInVisualSelection()
  -- 获取 Visual Mode 下选中的文本
  local start_pos = vim.fn.getpos("'<")  -- 获取选中区域的起始位置
  local end_pos = vim.fn.getpos("'>")    -- 获取选中区域的结束位置
  local selected_text = vim.fn.getreg('v')  -- 获取选中的文本内容

  -- 创建一个弹窗输入框 (这是一种非阻塞方式)
  vim.ui.input({
    prompt = 'Enter search term: ',
    default = selected_text,
    completion = "word",
  }, function(input)
    -- 如果用户输入了内容
    if input and input ~= "" then
      -- 恢复原来的 Visual 模式选中状态
      vim.fn.setpos("'<", start_pos)
      vim.fn.setpos("'>", end_pos)

      -- 执行搜索，并使用 \%V 限制搜索范围到选中的区域
      vim.fn.search('\\%V' .. vim.fn.escape(input, "/\\"))
    end
  end)
end

