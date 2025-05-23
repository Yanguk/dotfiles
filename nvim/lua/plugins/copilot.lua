local leetcode_config = require("configs.leetcode")

return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  opts = {
    suggestion = { enabled = false },
    panel = { enabled = false },
    copilot_model = "gpt-4o-copilot",
    type = "binary",
    custom_server_filepath = vim.fn.stdpath("data") .. "/mason/bin/copilot-language-server",
    should_attach = function(bufnr, bufname)
      if string.match(bufname, "env") then
        return false
      end

      return true
    end,
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
