return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false,
  opts = {
    provider = "copilot",
    behaviour = {
      auto_suggestions = false,
    },
    windows = {
      sidebar_header = {
        -- enabled = false,
        rounded = false,
      },
    },
    copilot = {
      -- model = "gemini-2.5-pro",
      -- model = "claude-3.7-sonnet",
      model = "gpt-4.1",
      -- disable_tooles = {
      --   "git_diff",
      --   "git_commit",
      --   "list_files",
      --   "search_files",
      --   "read_file",
      --   "create_file",
      --   "rename_file",
      --   "delete_file",
      --   "create_dir",
      --   "rename_dir",
      --   "delete_dir",
      --   "bash",
      -- },
    },
    -- system_prompt = function()
    --   local hub = require("mcphub").get_hub_instance()
    --   return hub:get_active_servers_prompt()
    -- end,
    -- -- The custom_tools type supports both a list and a function that returns a list. Using a function here prevents requiring mcphub before it's loaded
    -- custom_tools = function()
    --   return {
    --     require("mcphub.extensions.avante").mcp_tool(),
    --   }
    -- end,
  },
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "zbirenbaum/copilot.lua", -- for providers='copilot'
  },
}
