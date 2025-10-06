return {
  "ravitemer/mcphub.nvim",
  evnt = "VeryLazy",
  enabled = false,
  build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
  opts = {
    -- auto_approve = true,
  },
}
