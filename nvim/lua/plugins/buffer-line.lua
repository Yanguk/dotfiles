return {
  "akinsho/bufferline.nvim",
  lazy = false,
  version = "*",
  config = function()
    require("bufferline").setup({
      highlights = require("catppuccin.groups.integrations.bufferline").get(),
      options = {
        diagnostics = "nvim_lsp",
        ---@diagnostic disable-next-line: unused-local
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
      },
    })

    vim.g.transparent_groups = vim.list_extend(
      vim.g.transparent_groups or {},
      vim.tbl_map(function(v)
        return v.hl_group
      end, vim.tbl_values(require("bufferline.config").highlights))
    )
  end,
  keys = {
    { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Move to next buffer" },
    { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Move to previous buffer" },
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
}
