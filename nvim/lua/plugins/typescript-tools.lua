local default_config = require("configs.lspconfig")

return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  opts = {
    on_init = default_config.on_init,
    on_attach = default_config.on_attach,
    capabilities = default_config.capabilities,
    settings = {
      tsserver_file_preferences = {
        includeInlayParameterNameHints = "all",
        importModuleSpecifierPreference = "non-relative",
      },
      -- tsserver_plugins = {
      --   "@vue/typescript-plugin",
      -- },
    },
    root_markers = { "package.json" },
    single_file_support = true,
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      -- "vue",
    },
  },
}
