return {
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
}
