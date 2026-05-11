return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    opts = {
      size = 15,
      close_on_exit = true,
      shell = vim.o.shell,
      auto_scroll = false,
      float_opts = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        width = function()
          return math.floor(vim.o.columns * 0.85)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.8)
        end,
        winblend = 8,
        title = " Terminal ",
        title_pos = "center",
      },
      highlights = {
        FloatBorder = { guifg = "#7aa2f7" },
        NormalFloat = { guibg = "#1a1b26" },
        FloatTitle = { guifg = "#c0caf5", guibg = "#1a1b26" },
      },
      on_open = function(term)
        vim.cmd("setlocal nonumber norelativenumber signcolumn=no")
        vim.cmd("startinsert")
      end,
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      local Terminal = require("toggleterm.terminal").Terminal

      local horizontal_term = Terminal:new({
        direction = "horizontal",
        hidden = true,
      })

      local float_term = Terminal:new({
        direction = "float",
        hidden = true,
      })

      local float_term_alt = Terminal:new({
        direction = "float",
        hidden = true,
      })

      local map = vim.keymap.set
      map({ "n", "t" }, "<C-/>", function() horizontal_term:toggle() end, { desc = "Horizontal terminal" })
      map({ "n", "t" }, "<M-/>", function() float_term:toggle() end, { desc = "Float terminal" })
      map({ "n", "t" }, "<M-.>", function() float_term_alt:toggle() end, { desc = "Float terminal alt" })
    end,
  },
}
