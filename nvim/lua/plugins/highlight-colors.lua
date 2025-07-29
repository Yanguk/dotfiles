local init = false

return {
  "brenoprata10/nvim-highlight-colors",
  cmd = "HighlightColors",
  opts = {
    enable_tailwind = true,
  },
  keys = {
    {
      "<leader>th",
      function()
        if not init then
          require("nvim-highlight-colors").turnOn()
          init = true
        else
          require("nvim-highlight-colors").toggle()
        end
      end,
      "<cmd>HighlightColors Toggle<cr>",
      desc = "Toggle Highlight Colors",
    },
  },
  -- event = "BufReadPre",
}
