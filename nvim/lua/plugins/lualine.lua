return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "AndreM222/copilot-lualine",
  },
  opts = {},
  config = function()
    require("lualine").setup({
      theme = "catppuccin",
      sections = {
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
    })
  end,
}
