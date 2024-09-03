vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        underline=true,
        update_in_insert = false,
    }
)
vim.diagnostic.config({ float = { source = true } })

-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- -- Set to "ruff_lsp" to use the old LSP implementation version.
vim.g.lazyvim_python_lsp = "pyright"
vim.g.lazyvim_python_ruff = ""
vim.g.lazyvim_python_ruff_lsp = ""
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.foldmethod='indent'
vim.opt.colorcolumn='120'

