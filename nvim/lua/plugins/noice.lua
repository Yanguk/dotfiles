return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    messages = {
      view = "mini",
    },
  },
  config = function(_, opts)
    require("noice").setup(opts)

    require("notify").setup({
      stages = "static",
    })
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
}
