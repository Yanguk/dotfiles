local default_config = require("configs.lspconfig")

return {
  "pmizio/typescript-tools.nvim",
  enabled = not require("configs.leetcode").is_leetcode(),
  dependencies = { "nvim-lua/plenary.nvim" },
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
