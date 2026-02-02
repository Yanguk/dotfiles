return {
  "ahkohd/difft.nvim",
  keys = {
    {
      "<leader>dd",
      function()
        if Difft.is_visible() then
          Difft.hide()
        else
          Difft.diff()
        end
      end,
      desc = "Toggle Difft",
    },
  },
  opts = {
    command = "GIT_EXTERNAL_DIFF='difft --color=always' jj diff --no-pager", -- or "jj diff --no-pager"
    layout = "ivy_taller", -- nil (buffer), "float", or "ivy_taller"
  },
}
