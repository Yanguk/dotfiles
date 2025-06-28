return {
  "nvim-treesitter/nvim-treesitter",
  version = "*",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "lua", "luadoc", "printf", "vim", "vimdoc" },
      ignore_install = { "dockerfile" },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    })
  end,
}
