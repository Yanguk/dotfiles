return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "catppuccin/nvim",
  },
  config = function()
    local mocha = require("catppuccin.palettes").get_palette("mocha")

    require("bufferline").setup({
      highlights = require("catppuccin.groups.integrations.bufferline").get({
        styles = { "italic", "bold" },
        custom = {
          all = {
            fill = { bg = "#000000" },
          },
          mocha = {
            background = { fg = mocha.text },
          },
          latte = {
            background = { fg = "#000000" },
          },
        },
      }),
      options = {
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
      },
    })
  end,
  keys = {
    { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Move to next buffer" },
    { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Move to previous buffer" },
    { "<leader>x", "<Cmd>confirm bdelete<CR>", desc = "Buffer close" },
    { "<leader>X", "<Cmd>BufferLineCloseOthers<CR>", desc = "Buffer close others" },
    {
      "<leader>bs",
      function()
        local bufferline = require("bufferline")

        for _, e in ipairs(bufferline.get_elements().elements) do
          vim.schedule(function()
            vim.api.nvim_buf_call(e.id, function()
              vim.cmd("w!")
            end)
          end)
        end
      end,
      desc = "Buffer all force save",
    },
  },
  lazy = false,
}
