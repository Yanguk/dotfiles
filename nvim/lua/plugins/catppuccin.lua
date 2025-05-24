return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    integrations = {
      blink_cmp = true,
      diffview = true,
      grug_far = true,
      mason = true,
      noice = true,
      lsp_trouble = true,
      which_key = true,
      markview = true,
      snacks = {
        enabled = true,
        indent_scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
      },
    },
  },
  init = function()
    vim.cmd.colorscheme("catppuccin")
  end,
}
