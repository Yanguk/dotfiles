local leetcode_config = require("configs.leetcode")

return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  opts = {
    suggestion = { enabled = false },
    panel = { enabled = false },
    copilot_model = "gpt-4o-copilot",
    lsp_binary = vim.fn.stdpath("data") .. "/mason/bin/copilot-language-server",
  },
  config = function(_, opts)
    require("copilot").setup(opts)

    if leetcode_config.is_leetcode() then
      vim.schedule(function()
        vim.cmd("Copilot disable")
      end)
    end
  end,
}
