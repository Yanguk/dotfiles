return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false,
  opts = {
    provider = "copilot",
    -- provider = "ollama",
    behaviour = {
      use_cwd_as_project_root = true,
      auto_suggestions = false,
    },
    windows = {
      sidebar_header = {
        -- enabled = false,
        rounded = false,
      },
    },
    providers = {
      copilot = {
        -- model = "gemini-2.5-pro",
        -- model = "claude-3.7-sonnet",
        -- model = "gpt-4.1",
        -- model = "claude-sonnet-4",
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
      ollama = {
        endpoint = "http://localhost:11434",
        model = "gemma3",
      },
    },
    input = {
      provider = "snacks",
      provider_opts = {
        -- Additional snacks.input options
        title = "Avante Input",
        icon = " ",
      },
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
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
        },
      },
    },
  },
}
