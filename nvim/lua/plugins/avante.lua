return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  opts = {
    provider = "copilot",
    behaviour = {
      use_cwd_as_project_root = true,
    },
    copilot = {
      model = "gemini-2.5-pro",
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
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
  },
}
