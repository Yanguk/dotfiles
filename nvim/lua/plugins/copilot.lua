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
    should_attach = function(_bufnr, bufname)
      if not bufname or bufname == "" then
        return false
      end

      local excluded_patterns = { "env", "octo" }

      for _, pattern in ipairs(excluded_patterns) do
        if string.match(bufname, pattern) then
          return false
        end
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
