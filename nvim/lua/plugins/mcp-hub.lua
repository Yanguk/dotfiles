return {
  "ravitemer/mcphub.nvim",
  version = "*",
  cmd = "MCPHub", -- lazy load by default
  build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
  enabled = false,
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
  },
  opts = {
    extensions = {
      avante = {
        auto_approve_mcp_tool_calls = true, -- Auto approves mcp tool calls.
      },
    },
  },
}
