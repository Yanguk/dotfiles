return {
  "allaman/emoji.nvim",
  -- version = "1.0.0", -- optionally pin to a tag
  -- ft = "markdown", -- adjust to your needs
  dependencies = {
    -- util for handling paths
    "nvim-lua/plenary.nvim",
    -- optional for telescope integration
    "nvim-telescope/telescope.nvim",
  },
  opts = {},
  config = function(_, opts)
    require("emoji").setup(opts)
    require("telescope").load_extension("emoji")
  end,
  keys = {
    {
      "<leader>se",
      function()
        require("telescope").extensions.emoji.emoji()
      end,
      desc = "Search Emoji",
    },
  },
}
