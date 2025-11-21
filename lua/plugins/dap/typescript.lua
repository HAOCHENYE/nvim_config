return {
  name = "nvim-dap-typescript",
  dir = vim.fn.stdpath("config") .. "/lua/plugins/dap",
  ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  dependencies = { "mfussenegger/nvim-dap" },
  config = function()
    local ok, dap = pcall(require, "dap")
    if not ok then return end
        local dap = require("dap")
    if not dap.adapters["pwa-node"] then
      require("dap").adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          -- 💀 Make sure to update this path to point to your installation
          args = {
            LazyVim.get_pkg_path("js-debug-adapter", "/js-debug/src/dapDebugServer.js"),
            "${port}",
          },
        },
      }
    end
    if not dap.adapters["node"] then
      dap.adapters["node"] = function(cb, config)
        if config.type == "node" then
          config.type = "pwa-node"
        end
        local nativeAdapter = dap.adapters["pwa-node"]
        if type(nativeAdapter) == "function" then
          nativeAdapter(cb, config)
        else
          cb(nativeAdapter)
        end
      end
    end

    local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

    local vscode = require("dap.ext.vscode")
    vscode.type_to_filetypes["node"] = js_filetypes
    vscode.type_to_filetypes["pwa-node"] = js_filetypes

    for _, language in ipairs(js_filetypes) do
      if not dap.configurations[language] then
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
        }
      end
    end

    -- dap.adapters["pwa-node"] = {
    --   type = "server",
    --   host = "localhost",
    --   port = "9229",
    --   executable = {
    --     command = "js-debug-adapter",
    --     args = { "9229" },
    --   },
    -- }

  --   dap.configurations.javascript = {
  --     {
  --       type = "pwa-node",
  --       request = "launch",
  --       name = "Launch file",
  --       program = "${file}",
  --       cwd = "${workspaceFolder}",
  --     },
  --     {
  --       type = "pwa-node",
  --       request = "attach",
  --       name = "Attach",
  --       processId = require'dap.utils'.pick_process,
  --       cwd = "${workspaceFolder}",
  --     },
  -- }
  --   -- 如果希望 JS 也复用：
  --   dap.configurations["typescript"] = {
  --     {
  --       type = "pwa-node",
  --       request = "launch",
  --       name = "TS minimal",
  --       program = "${file}",
  --       cwd = "${workspaceFolder}",
  --       runtimeArgs = { "-r", "ts-node/register", "--inspect-brk" },
  --       env = { TS_NODE_COMPILER_OPTIONS = '{"sourceMap":true,"inlineSources":true}' },
  --       stopOnEntry = true,
  --       sourceMaps = true,
  --     },
  --
  --       {
  --         type = "pwa-node",
  --         request = "attach",
  --         name = "Attach to process ID",
  --         processId = require'dap.utils'.pick_process,
  --         cwd = "${workspaceFolder}",
  --       },
-- }
  end,
}

