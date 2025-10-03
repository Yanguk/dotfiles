return {
  "nvim-lualine/lualine.nvim",
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
          {
            function()
              return " "
            end,
            color = function()
              local status = require("sidekick.status").get()

              if status then
                return status.kind == "Error" and "DiagnosticError" or status.busy and "DiagnosticWarn" or "Special"
              end
            end,
            cond = function()
              local status = require("sidekick.status")
              return status.get() ~= nil
            end,
          },
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
