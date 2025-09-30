return {
  "eero-lehtinen/oklch-color-picker.nvim",
  event = "VeryLazy",
  version = "*",
  keys = {
    -- One handed keymap recommended, you will be using the mouse
    {
      "<leader>cv",
      function()
        require("oklch-color-picker").pick_under_cursor()
      end,
      desc = "Open Color pick under cursor",
    },
    {
      "<leader>co",
      function()
        require("oklch-color-picker").open_picker()
      end,
      desc = "Open Color picker",
    },
    {
      "<leader>ch",
      function()
        require("oklch-color-picker").highlight.toggle()
      end,
      desc = "Toggle highlight",
    },
  },
  ---@type oklch.Opts
  opts = {
    highlight = {
      enabled = false,
    },
  },
}
