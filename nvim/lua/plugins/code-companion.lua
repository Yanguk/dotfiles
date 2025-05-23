return {
  "olimorris/codecompanion.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          show_result_in_chat = true, -- Show mcp tool results in chat
          make_vars = true, -- Convert resources to #variables
          make_slash_commands = true, -- Add prompts as /slash commands
        },
      },
    },
    adapters = {
      copilot = function()
        return require("codecompanion.adapters").extend("copilot", {
          schema = {
            model = {
              default = "gemini-2.5-pro",
            },
          },
        })
      end,
    },
  },
  keys = {
    {
      "<leader>at",
      "<cmd>CodeCompanionChat Toggle<CR>",
      desc = "Toggle a chat buffe",
    },
    {
      "<leader>aa",
      "<cmd>CodeCompanionActions<CR>",
      desc = "Open the action palette",
    },
    {
      "<leader>aa",
      "<cmd>CodeCompanionChat Add<CR>",
      desc = "Add code to a chat buffer",
      mode = { "v" },
    },
    {
      "<leader>ae",
      function()
        vim.ui.input({ prompt = "Inline Prompt: " }, function(user_prompt)
          if user_prompt and #user_prompt > 0 then
            vim.cmd("'<,'>CodeCompanion " .. user_prompt)
          else
            print("CodeCompanion prompt cancelled or empty.")
          end
        end)
      end,
      desc = "Inline Assistant",
      mode = { "v" },
    },
  },
  init = function(_, opts)
    require("configs.codecompanion-spinner"):init()
  end,
}
