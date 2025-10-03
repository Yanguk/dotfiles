return {
  "akinsho/bufferline.nvim",
  lazy = false,
  version = "*",
  config = function()
    require("bufferline").setup({
      highlights = require("catppuccin.special.bufferline").get_theme(),
      options = {
        diagnostics = "nvim_lsp",
        ---@diagnostic disable-next-line: unused-local
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        -- numbers = function(opts)
        --   local state = require("bufferline.state")
        --   for i, buf in ipairs(state.components) do
        --     if buf.id == opts.id then
        --       return i
        --     end
        --   end
        --   return opts.ordinal
        -- end,
      },
    })

    for i = 1, 9 do
      vim.keymap.set(
        "n",
        string.format("<A-%d>", i),
        string.format('<cmd>lua require("bufferline").go_to_buffer(%d, true)<cr>', i),
        { silent = true }
      )
    end
  end,
  keys = {
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
