return {
  {
    "mg979/vim-visual-multi",
    init = function()
      -- 在插件加载后配置键映射
      vim.g.VM_maps = {
        ["Find Under"] = "<C-n>",
        ["Add Cursor Down"] = "<A-Down>",
        ["Find Subword Under"] = "<C-n>",
        ["Add Cursor Up"] = "<A-Up>",
      }
    end,
  },
  { "tpope/vim-surround" },
  {
    "folke/flash.nvim",
    keys = {
      { "S", mode = { "x", "o", "n" }, false },
    },
  },
  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = { -- Example mapping to toggle outline
      { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    opts = {
      -- Your setup opts here
    },
  },
  {
    "stevearc/conform.nvim",
    dependencies = {
      "rhysd/fixjson",
    },
    optional = true,
    opts = {
      formatters_by_ft = {
        ["python"] = { "black", "isort" },
        ["json"] = { "fixjson" },
      },
    },
  },
  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   opts = {
  --     filesystem = {
  --       watch_dir = false,
  --       enable_refresh_on_write = false,
  --     },
  --   },
  -- },
  {
    "saghen/blink.cmp",
    -- build = "cargo build --release",
    opts = {
      keymap = {
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<Tab>"] = { "select_and_accept", "fallback" },
      },
    },
  },
  {
    "ibhagwan/fzf-lua",
    opts = {
      lsp_references = {
        jump_to_single_result = true,
        silent = true,
      },
    },
  -- {
  -- "sphamba/smear-cursor.nvim",
  -- opts = {
  --     -- Smear cursor when switching buffers or windows.
  --     smear_between_buffers = true,
  --
  --     -- Smear cursor when moving within line or to neighbor lines.
  --     -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
  --     smear_between_neighbor_lines = true,
  --
  --     -- Draw the smear in buffer space instead of screen space when scrolling
  --     scroll_buffer_space = true,
  --
  --     -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
  --     -- Smears will blend better on all backgrounds.
  --     legacy_computing_symbols_support = false,
  --
  --     -- Smear cursor in insert mode.
  --     -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
  --     smear_insert_mode = true,
  --     cursor_color = "#55bfe3",
  --     stiffness = 0.3,
  --     trailing_stiffness = 0.1,
  --     damping = 0.5,
  --     trailing_exponent = 3,
  --     never_draw_over_target = true,
  --     hide_target_hack = true,
  --     gamma = 1,
  --   },
  -- },
  {
      "OXY2DEV/markview.nvim",
      lazy = false,
      priority = 49,
  },
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope.nvim",
    },
    config = function ()
      require"octo".setup()
    end
  },
  {
    "folke/snacks.nvim",
    opts = {
      scroll = {
        enabled = false,
      },
    },
    keys = {
      {
        "<leader>sb",
        function()
          local Snacks = require("snacks")
          Snacks.picker.grep({
            need_search = false,
            args = { "--max-columns=10000" },
            dirs = { vim.api.nvim_buf_get_name(0) },
            layout = {
              preset = "ivy",
              auto_hide = { "preview" },
            },
            format = function(item)
              local ret = { { string.format("%s: ", item.pos[1]), "Conceal" } }
              Snacks.picker.highlight.format(item, item.line, ret)
              return ret
            end,
          })
        end,
        desc = "Snacks grep in current file",
      },
      -- {
      --   "<c-/>",
      --   function() Snacks.terminal() end, { desc = "Terminal (cwd)" }
      -- }
    },
  }
},
  {
    "iamcco/markdown-preview.nvim",
    init = function()
      vim.g.mkdp_echo_preview_url = 1
      vim.g.mkdp_port = "8879"
    end,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    -- if markdown-preview does not work, maybe need to call `call mkdp#util#install` again in nvim
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
}
