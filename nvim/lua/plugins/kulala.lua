return {
  "mistweaverco/kulala.nvim",
  cmd = "KulalaScratchpad",
  ft = { "http", "rest" },
  opts = {
    -- your configuration comes here
    global_keymaps = true,
    global_keymaps_prefix = "<leader>R",
    kulala_keymaps_prefix = "",
    default_env = "staging",
  },
  config = function(_, opts)
    require("kulala").setup(opts)

    vim.api.nvim_create_user_command("KulalaScratchpad", function()
      require("kulala").scratchpad()
    end, { desc = "Open Kulala Scratchpad" })
  end,
}
