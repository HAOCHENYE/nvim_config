local dap_python = require("dap-python")
dap_python.setup("python")


local dap = require("dap")
-- Configure attach mode
dap.configurations.python[3]["justMyCode"] = false

local function list_sessions()
  local sessions = dap.sessions()
  local session_list = {}
  local cur_session = dap.session()
  local function traverse_sessions(session_tree, prefix)
    for key, session in pairs(session_tree) do
      local flag = " " -- whether the session is the current session
      if session == cur_session then
        flag = "*"
      end
      local status = "running"
      if session.threads[1].stopped then
        status = "stopped"
      end
      table.insert(session_list, string.format("%s%s[%d] %s", prefix, flag, key, status))
      if session.children then
        traverse_sessions(session.children, prefix .. "  ")
      end
    end
  end
  traverse_sessions(sessions, "")
  return session_list
end
-- function to display and switch sessions
local function switch_session()
  local session_list = list_sessions()
  if #session_list == 0 then
    vim.notify("no active debug sessions.", vim.log.levels.warn)
    return
  end
  local choices = {}
  for i, session in ipairs(session_list) do
    table.insert(choices, string.format("%d: %s", i, session))
  end
  vim.ui.select(choices, { prompt = "select a session to switch to:" }, function(choice)
    if choice then
      local selected_index = tonumber(choice:match("^(%d+):"))
      local session_key = session_list[selected_index]:match("%[(%d+)%]")
      if session_key then
        local session_id = tonumber(session_key)
        local sessions = dap.sessions()
        local function find_session(tree, id)
          if tree[id] then
            return tree[id]
          end
          for _, sub_tree in pairs(tree) do
            if sub_tree.children then
              local found = find_session(sub_tree.children, id)
              if found then
                return found
              end
            end
          end
          return nil
        end
        local target_session = find_session(sessions, session_id)
        if target_session then
          dap.set_session(target_session)
          vim.notify("switched to session: " .. session_id, vim.log.levels.info)
        else
          vim.notify("session not found.", vim.log.levels.error)
        end
      end
    end
  end)
end

-- 自定义调试符号
vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "Error", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "❌", texthl = "Warning", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "Debug", linehl = "DebugPC", numhl = "DebugPC" })

-- 自定义高亮
vim.cmd([[highlight DebugPC ctermbg=yellow guibg=yellow guifg=black]])
vim.cmd([[highlight DebugBreakpoint ctermbg=red guibg=red guifg=white]])

-- Close all dap sessions
local function close_all_sessions()
  local session_list = list_sessions()
  if #session_list == 0 then
    vim.notify("no active debug sessions.", vim.log.levels.warn)
    return
  end

  -- Terminate each session
  for _, session in ipairs(session_list) do
    dap.terminate(session)
  end

  vim.notify("All debug sessions closed.", vim.log.levels.INFO)
end

-- 可以绑定到一个命令
vim.api.nvim_create_user_command("DapCloseAllSessions", close_all_sessions, {})
vim.api.nvim_create_user_command("DapSwitchSession", switch_session, {})
-- 设置 `nvim-dap` 插件的默认行为（如果有必要）
dap.defaults.fallback.external_terminal = { "alacritty", "-e" }
-- dap.adapters.python = {
--     type = 'executable';
--     command = "/root/miniconda3/bin/python",
--     args = { '-m', 'debugpy.adapter', '--host', "0.0.0.0", '--port', '5678'}
-- }
-- dap.adapters.python = {
--     type = 'server',
--     options = {
--         max_retries = 1000,
--     }
-- }                                           --         type = 'python',
--         request = 'launch',
--         name = 'happy happy',
--         pythonPath = "/root/miniconda3/bin/python",
--         program = "${file}",
--     }
-- }
--

-- dap.configurations.python = {
--     {
--         type = 'python',
--         request = 'attach',
--         name = 'attach program',
--         -- connect = {
--         --     host = '0.0.0.0',
--         --     port = 5678,
--         -- },
--     }
-- }
--
--
-- vim.cmd('command! DapSwitchSession lua DapSwitchSession()')
--
-- function DapSwitchSession()
--   local dap = require("dap")
--   local sessions = dap.sessions()
--   vim.print(sessions)
--   for _, s in pairs(sessions["children"]) do
--       if not s.closed then
--         print("set session:", vim.inspect(s))
--         dap.set_session(s)
--         return
--     end
--   end
-- end
