return {
  "ravitemer/mcphub.nvim",
  -- enabled = false,
  -- lazy = "VeryLazy",
  version = "*",
  cmd = "MCPHub", -- lazy load by default
  build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
  },
  opts = {
    -- auto_approve = true,
    extensions = {
      avante = {
        make_slash_commands = true, -- make /slash commands from MCP server prompts
      },
    },
  },
}
