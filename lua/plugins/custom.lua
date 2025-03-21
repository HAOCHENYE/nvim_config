return {
  {
    "petertriho/nvim-scrollbar",
    dependencies = {
      "kevinhwang91/nvim-hlslens",
      "lewis6991/gitsigns.nvim",
    },
    opts = {
      show = true,
      show_in_active_only = false,
      set_highlights = true,
      folds = 1000, -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
      max_lines = false, -- disables if no. of lines in buffer exceeds this
      hide_if_all_visible = false, -- Hides everything if all lines are visible
      throttle_ms = 100,
      handle = {
        text = " ",
        blend = 30, -- Integer between 0 and 100. 0 for fully opaque and 100 to full transparent. Defaults to 30.
        color = nil,
        color_nr = nil, -- cterm
        highlight = "CursorColumn",
        hide_if_all_visible = true, -- Hides handle if all lines are visible
      },
      marks = {
        Cursor = {
          text = "•",
          priority = 0,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = "Normal",
        },
        Search = {
          text = { "-", "=" },
          priority = 1,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = "Search",
        },
        Error = {
          text = { "-", "=" },
          priority = 2,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = "DiagnosticVirtualTextError",
        },
        Warn = {
          text = { "-", "=" },
          priority = 3,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = "DiagnosticVirtualTextWarn",
        },
        Info = {
          text = { "-", "=" },
          priority = 4,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = "DiagnosticVirtualTextInfo",
        },
        Hint = {
          text = { "-", "=" },
          priority = 5,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = "DiagnosticVirtualTextHint",
        },
        Misc = {
          text = { "-", "=" },
          priority = 6,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = "Normal",
        },
        GitAdd = {
          text = "┆",
          priority = 7,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = "GitSignsAdd",
        },
        GitChange = {
          text = "┆",
          priority = 7,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = "GitSignsChange",
        },
        GitDelete = {
          text = "▁",
          priority = 7,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = "GitSignsDelete",
        },
      },
      excluded_buftypes = {
        "terminal",
      },
      excluded_filetypes = {
        "cmp_docs",
        "cmp_menu",
        "noice",
        "prompt",
        "TelescopePrompt",
      },
      autocmd = {
        render = {
          "BufWinEnter",
          "TabEnter",
          "TermEnter",
          "WinEnter",
          "CmdwinLeave",
          "TextChanged",
          "VimResized",
          "WinScrolled",
        },
        clear = {
          "BufWinLeave",
          "TabLeave",
          "TermLeave",
          "WinLeave",
        },
      },
      handlers = {
        cursor = true,
        diagnostic = true,
        gitsigns = true, -- Requires gitsigns
        handle = true,
        search = true, -- Requires hlslens
        ale = false, -- Requires ALE
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = { python = { "mypy", "flake8" } },
    },
    init = function()
      local mypy = require("lint").get_namespace("mypy")
      local flake8 = require("lint").get_namespace("flake8")
      local new_args = {
        "--max-line-length=119",
      }
      local args = require("lint").linters.flake8.args
      for _, arg in ipairs(new_args) do
        table.insert(args, arg)
      end

      vim.diagnostic.config({ virtual_text = false, float = { source = true } }, mypy)
      vim.diagnostic.config({ virtual_text = false, float = { source = true } }, flake8)
    end,
  },
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
  {
    "sindrets/diffview.nvim",
    -- init = function ()
    --     vim.api.nvim_set_hl(0, 'DiffviewDiffAddAsDelete', { bg = "#431313" })
    --     vim.api.nvim_set_hl(0, 'DiffDelete', { bg = "#FF0000", fg = "#FF0000" })
    --     vim.api.nvim_set_hl(0, 'DiffviewDiffDelete', { bg = "#FF0000", fg = "#FF0000" })
    --     vim.api.nvim_set_hl(0, 'DiffAdd', { bg = "#142a03" })
    --     vim.api.nvim_set_hl(0, 'DiffChange', { bg = "#3B3307" })
    --     vim.api.nvim_set_hl(0, 'DiffText', { bg = "#4D520D" })
    -- end,
    opts = {
      enhanced_diff_hl = true,
      -- DiffDelete = { fg = "#FF0000", bg = "#FF0000", style = "reverse" },
      -- DiffviewDiffDelete = { fg = "#FF0000", bg = "#FF0000", style = "reverse" },
    },
  },
  { "tpope/vim-surround" },
  {
    "folke/flash.nvim",
    keys = {
      { "S", mode = { "x", "o", "n" }, false },
    },
  },
  { "mfussenegger/nvim-dap" },
  { "mfussenegger/nvim-dap-python" },
  { "rcarriga/nvim-dap-ui"},
  { "theHamsta/nvim-dap-virtual-text", enabled=false},
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
  { "akinsho/toggleterm.nvim", version = "*", config = true },
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
  { "jesseduffield/lazygit" },
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
      -- See Configuration section for rest
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
       local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable signature help in insert mode
       keys[#keys + 1] = { "<C-k>", false, mode = "i" }
       opts.diagnostics.virtual_text = false
       opts.diagnostics.float = { source = true }
       return opts
    end,
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
  { "zbirenbaum/copilot-cmp", enabled = false },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        watch_dir = false,
        enable_refresh_on_write = false,
      },
    },
  },
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
    "giuxtaposition/blink-cmp-copilot",
    enabled = false,
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
  {
    "AckslD/swenv.nvim",
    opts = {
      get_venvs = function(venvs_path)
        -- The implementation in swenv.api has some issues. This is a temp fix
        local venvs = require("swenv.api").get_venvs(venvs_path)
        local scan_dir = require("plenary.scandir").scan_dir
        local Path = require("plenary.path")
        local conda_exe = vim.fn.getenv("CONDA_EXE")
        if conda_exe ~= vim.NIL then
          local conda_base = (Path:new(conda_exe):parent():parent() / "envs").filename
          local paths = scan_dir(conda_base, { depth = 1, only_dirs = true, silent = true })
          for _, path in ipairs(paths) do
            table.insert(venvs, {
              name = Path:new(path):make_relative(conda_base),
              path = path,
              source = "conda",
            })
          end
        end
        return venvs
      end,
      post_set_venv = function(venv)
        -- Restart LSP to reload the new venv
        vim.cmd("LspRestart")
      end,
    },
    keys = {
      {
        "<leader>se",
        function()
          require("swenv.api").pick_venv()
        end,
        desc = "Switch Python Virtual Environment",
      },
    },
  },
}
  -- {
  --   "xiantang/darcula-dark.nvim"
  -- },
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "darcula-dark",
  --   },
  -- }
-- }
-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
-- if true then return {} end
-- 
-- -- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
-- --
-- -- In your plugin files, you can:
-- -- * add extra plugins
-- -- * disable/enabled LazyVim plugins
-- -- * override the configuration of LazyVim plugins
-- return {
--   -- add gruvbox
--   { "ellisonleao/gruvbox.nvim" },
-- 
--   -- Configure LazyVim to load gruvbox
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "gruvbox",
--     },
--   },
-- 
--   -- change trouble config
--   {
--     "folke/trouble.nvim",
--     -- opts will be merged with the parent spec
--     opts = { use_diagnostic_signs = true },
--   },
-- 
--   -- disable trouble
--   { "folke/trouble.nvim", enabled = false },
-- 
--   -- override nvim-cmp and add cmp-emoji
--   {
--     "hrsh7th/nvim-cmp",
--     dependencies = { "hrsh7th/cmp-emoji" },
--     ---@param opts cmp.ConfigSchema
--     opts = function(_, opts)
--       table.insert(opts.sources, { name = "emoji" })
--     end,
--   },
-- 
--   -- change some telescope options and a keymap to browse plugin files
--   {
--     "nvim-telescope/telescope.nvim",
--     keys = {
--       -- add a keymap to browse plugin files
--       -- stylua: ignore
--       {
--         "<leader>fp",
--         function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
--         desc = "Find Plugin File",
--       },
--     },
--     -- change some options
--     opts = {
--       defaults = {
--         layout_strategy = "horizontal",
--         layout_config = { prompt_position = "top" },
--         sorting_strategy = "ascending",
--         winblend = 0,
--       },
--     },
--   },
-- 
--   -- add pyright to lspconfig
--   {
--     "neovim/nvim-lspconfig",
--     ---@class PluginLspOpts
--     opts = {
--       ---@type lspconfig.options
--       servers = {
--         -- pyright will be automatically installed with mason and loaded with lspconfig
--         pyright = {},
--       },
--     },
--   },
-- 
--   -- add tsserver and setup with typescript.nvim instead of lspconfig
--   {
--     "neovim/nvim-lspconfig",
--     dependencies = {
--       "jose-elias-alvarez/typescript.nvim",
--       init = function()
--         require("lazyvim.util").lsp.on_attach(function(_, buffer)
--           -- stylua: ignore
--           vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
--           vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
--         end)
--       end,
--     },
--     ---@class PluginLspOpts
--     opts = {
--       ---@type lspconfig.options
--       servers = {
--         -- tsserver will be automatically installed with mason and loaded with lspconfig
--         tsserver = {},
--       },
--       -- you can do any additional lsp server setup here
--       -- return true if you don't want this server to be setup with lspconfig
--       ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
--       setup = {
--         -- example to setup with typescript.nvim
--         tsserver = function(_, opts)
--           require("typescript").setup({ server = opts })
--           return true
--         end,
--         -- Specify * to use this function as a fallback for any server
--         -- ["*"] = function(server, opts) end,
--       },
--     },
--   },
-- 
--   -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
--   -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
--   { import = "lazyvim.plugins.extras.lang.typescript" },
-- 
--   -- add more treesitter parsers
--   {
--     "nvim-treesitter/nvim-treesitter",
--     opts = {
--       ensure_installed = {
--         "bash",
--         "html",
--         "javascript",
--         "json",
--         "lua",
--         "markdown",
--         "markdown_inline",
--         "python",
--         "query",
--         "regex",
--         "tsx",
--         "typescript",
--         "vim",
--         "yaml",
--       },
--     },
--   },
-- 
--   -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
--   -- would overwrite `ensure_installed` with the new value.
--   -- If you'd rather extend the default config, use the code below instead:
--   {
--     "nvim-treesitter/nvim-treesitter",
--     opts = function(_, opts)
--       -- add tsx and treesitter
--       vim.list_extend(opts.ensure_installed, {
--         "tsx",
--         "typescript",
--       })
--     end,
--   },
-- 
--   -- the opts function can also be used to change the default opts:
--   {
--     "nvim-lualine/lualine.nvim",
--     event = "VeryLazy",
--     opts = function(_, opts)
--       table.insert(opts.sections.lualine_x, "😄")
--     end,
--   },
-- 
--   -- or you can return new options to override all the defaults
--   {
--     "nvim-lualine/lualine.nvim",
--     event = "VeryLazy",
--     opts = function()
--       return {
--         --[[add your custom lualine config here]]
--       }
--     end,
--   },
-- 
--   -- use mini.starter instead of alpha
--   { import = "lazyvim.plugins.extras.ui.mini-starter" },
-- 
--   -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
--   { import = "lazyvim.plugins.extras.lang.json" },
-- 
--   -- add any tools you want to have installed below
--   {
--     "williamboman/mason.nvim",
--     opts = {
--       ensure_installed = {
--         "stylua",
--         "shellcheck",
--         "shfmt",
--         "flake8",
--       },
--     },
--   },
-- }
