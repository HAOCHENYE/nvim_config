return {
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

    -- Configure mypy args
    local mypy_new_args = {
      "--follow-imports=skip",
      "--config-file=" .. os.getenv("HOME") .. "/.mypy.ini",
    }
    local mypy_args = require("lint").linters.mypy.args
    for _, arg in ipairs(mypy_new_args) do
      table.insert(mypy_args, arg)
    end

      vim.diagnostic.config({ virtual_text = false, float = { source = true } }, mypy)
      vim.diagnostic.config({ virtual_text = false, float = { source = true } }, flake8)
    end,
  },
}
