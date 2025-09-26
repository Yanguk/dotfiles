-- return {
--   "catppuccin/nvim",
--   name = "catppuccin",
--   priority = 1000,
--   opts = {
--     transparent_background = true,
--     auto_integrations = true,
--   },
--   init = function()
--     vim.cmd.colorscheme("catppuccin")
--   end,
-- }

return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  opts = {
    compile = true, -- enable compiling the colorscheme
    theme = "wave", -- Load "wave" theme when 'background' option is not set
    transparent = true,
    colors = {
      theme = {
        all = {
          ui = {
            bg_gutter = "none",
          },
        },
      },
    },
    overrides = function(colors)
      local theme = colors.theme

      return {
        NormalFloat = { bg = "none" },
        FloatBorder = { bg = "none" },
        FloatTitle = { bg = "none" },

        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
        PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
        PmenuSbar = { bg = theme.ui.bg_m1 },
        PmenuThumb = { bg = theme.ui.bg_p2 },
      }
    end,
  },
  init = function()
    vim.cmd.colorscheme("kanagawa")
  end,
}
