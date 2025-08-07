-- cSpell:disable
return {
  "mfussenegger/nvim-lint",
  event = "VeryLazy",
  config = function()
    local nvim_lint = require("lint")
    local cspell_config = require("configs.cspell")

    nvim_lint.linters_by_ft = {}

    local origin_cspell = nvim_lint.linters.cspell

    table.insert(origin_cspell.args, "--config")
    table.insert(origin_cspell.args, cspell_config.get_cspell_path())

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      callback = function()
        nvim_lint.try_lint("cspell")
      end,
    })
  end,
}
