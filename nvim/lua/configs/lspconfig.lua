local default_config = {
  capabilities = {
    textDocument = {
      -- nvim-ufo (ts 에서 배열을 폴드할려면 lsp로 해야함)
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      },
    },
  },
  on_init = function(client)
    client.server_capabilities.semanticTokensProvider = nil
  end,
  on_attach = function(client, bufnr)
    local function opts(desc)
      return { buffer = bufnr, desc = desc }
    end

    if client.server_capabilities.inlayHintProvider then
      vim.keymap.set("n", "<leader>ih", function()
        local current_setting = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })

        vim.lsp.inlay_hint.enable(not current_setting, { bufnr = bufnr })
      end, opts("toggle [I]nlay [H]ints"))
    end
  end,
}

return default_config
