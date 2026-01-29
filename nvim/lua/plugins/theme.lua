-- return {
--   "catppuccin/nvim",
--   name = "catppuccin",
--   priority = 1200,
--   opts = {
--     -- flavour = "mocha",
--     transparent_background = true,
--     auto_integrations = true,
--   },
--   config = function(_, opts)
--     require("catppuccin").setup(opts)
--
--     vim.cmd.colorscheme("catppuccin")
--   end,
-- }
--

return {
  "rebelot/kanagawa.nvim",
  priority = 1200,
  opts = {
    -- theme = "dragon",
    -- background = { dark = "dragon" },
    -- transparent = true,
    overrides = function(colors)
      local theme = colors.theme
      return {
        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency,,
        PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
        PmenuSbar = { bg = theme.ui.bg_m1 },
        PmenuThumb = { bg = "#C0A36E" },
        BlinkCmpMenuBorder = { fg = "", bg = "" },

        NormalFloat = { bg = "none" },
        FloatBorder = { bg = "none" },
        FloatTitle = { bg = "none" },
        -- LineNr = { fg = "#C0A36E", bg = "NONE" },
        CursorLineNr = { fg = colors.palette.sakuraPink, bg = "NONE" },
      }
    end,
  },
  init = function()
    vim.cmd("colorscheme kanagawa")
  end,
}
