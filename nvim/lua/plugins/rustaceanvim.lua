return {
  "mrcjkb/rustaceanvim",
  version = "*", -- Recommended
  lazy = false, -- This plugin is already lazy
  init = function()
    local default_config = require("configs.lspconfig")

    vim.g.rustaceanvim = {
      server = {
        on_init = default_config.on_init,
        on_attach = default_config.on_attach,
        capabilities = default_config.capabilities,
      },
    }
  end,
}
