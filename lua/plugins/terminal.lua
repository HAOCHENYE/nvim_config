return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      terminal = {
        -- your terminal configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
    },
    init = function()
      local Snacks = require("snacks")
      local Terminal = require("snacks.terminal")

      -- Create a mapping to store terminal names
      local terminal_names = {}

      local function snacks_terminal_pick()
        local terms = Terminal.list()
        if #terms == 0 then
          Snacks.notify.warn("No terminals")
          return
        end
        table.sort(terms, function(a, b)
          local ia = (vim.b[a.buf].snacks_terminal or {}).id or 9999
          local ib = (vim.b[b.buf].snacks_terminal or {}).id or 9999
          return ia < ib
        end)

        -- 仅传字符串给 vim.ui.select，避免 deepcopy userdata
        local labels = {}
        local term_refs = {}

        for _, t in ipairs(terms) do
          local buf = tonumber(t.buf)
          if buf and vim.api.nvim_buf_is_valid(buf) then
            local meta = vim.b[buf].snacks_terminal or {}
            local id = meta.id or "?"
            local title = vim.b[buf].term_title
            local cmd = meta.cmd or ""
            local cmd_str = type(cmd) == "table" and table.concat(cmd, " ") or cmd
            if not cmd_str or cmd_str == "" then
              cmd_str = vim.o.shell
            end
            local bname = vim.api.nvim_buf_get_name(buf)
            local cwd = bname and bname:match("^term://(.-):%d+:.+") or nil
            if cwd then
              cwd = vim.fn.fnamemodify(cwd, ":~")
            end
            local desc = meta.desc and (" [" .. meta.desc .. "]") or ""

            local name = ""
            if terminal_names[buf] then
              name = " «" .. terminal_names[buf] .. "»"
            end

            local label = string.format(
              "#%s %s%s%s%s",
              id,
              (title and title ~= "" and title) or cmd_str,
              cwd and ("  [" .. cwd .. "]") or "",
              desc,
              name
            )

            table.insert(labels, label)
            table.insert(term_refs, t)
          end
        end

        if #labels == 0 then
          Snacks.notify.warn("No terminals")
          return
        end

        vim.ui.select(labels, {
          prompt = "Snacks Terminals",
        }, function(_, idx)
          local sel = idx and term_refs[idx]
          if sel then
            sel:toggle()
          end
        end)
      end

      vim.keymap.set("n", "<leader>tt", snacks_terminal_pick, { desc = "Snacks: Select Terminal" })

      vim.api.nvim_create_user_command("SnackTerminal", function(opts)
        local args = vim.split(opts.args, " ", { trimempty = true })
        local terminal_name = args[1] or ""
        local cmd = #args > 1 and table.concat({ unpack(args, 2) }, " ") or nil

        -- Create terminal with the specified command
        local term = Snacks.terminal(cmd, {
          position = "bottom",
          desc = terminal_name, -- Set the terminal name as description
        })

        -- Store the name in our mapping if provided
        if terminal_name and terminal_name ~= "" and term and term.buf then
          terminal_names[term.buf] = terminal_name
        end
      end, { nargs = "*", complete = "shellcmd" })

      -- Add a command to name an existing terminal
      vim.api.nvim_create_user_command("SnackTermName", function(opts)
        local name = opts.args
        local buf = vim.api.nvim_get_current_buf()

        -- Check if this is a terminal buffer
        local meta = vim.b[buf].snacks_terminal
        if not meta then
          Snacks.notify.warn("Not a Snacks terminal buffer")
          return
        end

        -- Store the name
        terminal_names[buf] = name
        Snacks.notify.info("Terminal named: " .. name)
      end, { nargs = 1 })
    end,
  },
}
