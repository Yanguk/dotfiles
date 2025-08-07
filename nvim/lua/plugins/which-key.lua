return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  config = function()
    require("which-key").add({
      { "<leader>ei", group = "Emoji insert", icon = "😊" },
      { "<leader>eit", icon = "👍" },
      { "<leader>eic", icon = "💥" },
      { "<leader>eir", icon = "🚀" },
      { "<leader>ca", icon = "📝" },
    })
  end,
}
