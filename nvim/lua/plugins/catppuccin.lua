return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1200,
  opts = {
    -- flavour = "mocha",
    transparent_background = true,
    auto_integrations = true,
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)

    vim.cmd.colorscheme("catppuccin")
  end,
}
