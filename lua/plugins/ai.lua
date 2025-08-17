return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      debug = true, -- Enable debugging
      model = 'gpt-5'
      -- See Configuration section for rest
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        filetypes = {
          markdown = true,
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        -- 设置高亮颜色
        vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#F0E68C" }),
      })
    end,
  },
  -- 不在 cmp 里体现 ai 提示，只通过 virtual text 里提示
  { "zbirenbaum/copilot-cmp", enabled = false },
  {
    "giuxtaposition/blink-cmp-copilot",
    enabled = false,
  },
}
