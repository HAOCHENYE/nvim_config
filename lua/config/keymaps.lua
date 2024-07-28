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

local function toggle_neotree()
 vim.cmd('Neotree show')
end

vim.keymap.set('n', '<leader>to', '<cmd>Neotree show<CR>')
vim.keymap.set('n', '<leader>tq', '<cmd>Neotree close<CR>')
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
vim.api.nvim_set_keymap('n', '<leader>bd', ':bp | bd #<CR>', { noremap = true, silent = true })


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

vim.keymap.set('v', '<Tab>', '>gv')
vim.keymap.set('v', '<S-Tab>', '<gv')
vim.keymap.set('n', '<Tab>', '>>')
vim.keymap.set('n', '<S-Tab>', '<<')
vim.keymap.set('n', '<leader>po', '<cmd>put _<cr>i')
  
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


-- 重新绑定 C-o 到 Alt-h
vim.api.nvim_set_keymap('n', '<A-h>', '<C-o>', { noremap = true, silent = true })
-- 重新绑定 C-i 到 Alt-l
vim.api.nvim_set_keymap('n', '<A-l>', '<C-i>', { noremap = true, silent = true })
