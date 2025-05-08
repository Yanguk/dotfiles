return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    messages = {
      view = "mini",
    },
    routes = {
      {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = {
          skip = true,
        },
      },
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
