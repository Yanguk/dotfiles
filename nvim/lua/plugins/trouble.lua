return {
  "folke/trouble.nvim",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  keys = {
    {
      "<leader>lx",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>lX",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    -- {
    --   "<leader>cs",
    --   "<cmd>Trouble symbols toggle focus=false<cr>",
    --   desc = "Symbols (Trouble)",
    -- },
    -- {
    --   "<leader>cl",
    --   "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
    --   desc = "LSP Definitions / references / ... (Trouble)",
    -- },
    -- {
    --   "<leader>xL",
    --   "<cmd>Trouble loclist toggle<cr>",
    --   desc = "Location List (Trouble)",
    -- },
    -- {
    --   "<leader>xQ",
    --   "<cmd>Trouble qflist toggle<cr>",
    --   desc = "Quickfix List (Trouble)",
    -- },
    {
      "gd",
      "<cmd>Trouble lsp_definitions toggle focus=true auto_refresh=false<cr>",
      desc = "LSP Definitions (Trouble)",
    },
    {
      "grr",
      "<cmd>Trouble lsp_references toggle focus=true auto_refresh=false<cr>",
      desc = "LSP References (Trouble)",
    },
    {
      "gri",
      "<cmd>Trouble lsp_implementations toggle focus=true auto_refresh=false<cr>",
      desc = "LSP Implementations (Trouble)",
    },
    {
      "grD",
      "<cmd>Trouble lsp_type_definition toggle focus=true auto_refresh=false<cr>",
      desc = "LSP Type Definitions (Trouble)",
    },
  },
}
