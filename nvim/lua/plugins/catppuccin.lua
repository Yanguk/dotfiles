return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    integrations = {
      avante = true,
      blink_cmp = true,
      diffview = true,
      grug_far = true,
      mason = true,
      noice = true,
      lsp_trouble = true,
      which_key = true,
      render_markdown = true,
      octo = true,
      snacks = {
        enabled = true,
        indent_scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
      },
      navic = {
        enabled = true,
        custom_bg = "NONE", -- Use the default background color
      },
    },
  },
  init = function()
    vim.cmd.colorscheme("catppuccin")
  end,
}
