return {
  "michaelb/sniprun",
  branch = "master",
  build = "sh install.sh",
  opts = {},
  keys = {
    {
      "<leader>cr",
      ":let b:caret=winsaveview() <CR> | :lua require'sniprun.api'.run_range(1, vim.api.nvim_win_get_cursor(0)[1]) <CR> | :call winrestview(b:caret) <CR>",
      desc = "run code",
    },
  },
}
