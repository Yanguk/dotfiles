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
          any = {
            { find = "No information available" },
            { find = "Content is not an image." },
          },
        },
        opts = {
          skip = true,
        },
      },
    },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
}
