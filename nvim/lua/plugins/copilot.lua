local leetcode_config = require("configs.leetcode")

return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  opts = {
    filetypes = {
      markdown = false,
      octo = false,
      mdx = false,
      sh = function()
        if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
          -- disable for .env files
          return false
        end
        return true
      end,
      [""] = false,
    },
    suggestion = { enabled = false },
    panel = { enabled = false },
    server = {
      type = "binary",
      custom_server_filepath = vim.fn.stdpath("data") .. "/mason/bin/copilot-language-server",
    },
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
