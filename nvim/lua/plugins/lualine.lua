return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "AndreM222/copilot-lualine",
  },
  opts = {},
  config = function()
    require("lualine").setup({
      theme = "catppuccin",
      sections = {
        lualine_c = { { "filename", path = 2 } },
        lualine_x = {
          {
            require("noice").api.status.mode.get,
            cond = require("noice").api.status.mode.has,
            color = { fg = "#ff9e64" },
          },
          -- require("mcphub.extensions.lualine"),
          "copilot",
          "encoding",
          "fileformat",
          "filetype",
        },
      },
      winbar = {
        lualine_c = {
          {
            "navic",
          },
        },
      },
    })
  end,
}
