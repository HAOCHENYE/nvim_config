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
  },
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   init = function()
  --     vim.g.mkdp_echo_preview_url = 1
  --     vim.g.mkdp_port = "8879"
  --   end,
  --   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --   ft = { "markdown" },
  --   -- if markdown-preview does not work, maybe need to call `call mkdp#util#install` again in nvim
  --   build = function()
  --     vim.fn["mkdp#util#install"]()
  --   end,
  -- },
}
