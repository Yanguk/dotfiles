return {
  "ravitemer/mcphub.nvim",
  cmd = "MCPHub", -- lazy load by default
  build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
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
