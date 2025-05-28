return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  opts = {
    preview = {
      filetypes = { "markdown", "codecompanion" },
      ignore_buftypes = {},
      modes = { "n", "no", "c", "i" },
      hybrid_modes = { "i", "n" },
      linewise_hybrid_mode = true,
      icon_provider = "internal",
    },
  },
  dependencies = {
    "saghen/blink.cmp",
  },
}
