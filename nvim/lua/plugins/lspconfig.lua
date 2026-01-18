-- cSpell:disable
return {
  "neovim/nvim-lspconfig",
  lazy = false,
  config = function()
    local default_config = require("configs.lspconfig")
    local eslint_base_on_attach = vim.lsp.config.eslint.on_attach

    -- set server config
    local server_configs = {
      kulala_ls = {},
      lua_ls = {},
      zls = {},
      yamlls = {},
      -- graphql = {},
      prismals = {},
      docker_compose_language_service = {},
      dockerls = {},
      nil_ls = {},
      terraformls = {},
      pyright = {},
      codebook = {},
      -- NOTE: typos 대신 cspell 사용경험이 좋았음
      -- typos_lsp = {
      --   init_options = {
      --     config = "~/.config/nvim/typos.toml",
      --   },
      -- },
      -- cspell_ls = {
      --   cmd = { "cspell-lsp", "--stdio", "--config", require("configs.cspell").get_cspell_path() },
      --   root_markers = {},
      -- },
      biome = {},
      eslint = {
        on_attach = function(client, bufnr)
          default_config.on_attach(client, bufnr)

          if eslint_base_on_attach then
            eslint_base_on_attach(client, bufnr)

            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              command = "LspEslintFixAll",
            })
          end
        end,
      },
      bashls = {
        filetypes = { "sh", "zsh", "bash" },
      },
      clangd = {
        capabilities = vim.tbl_deep_extend("force", default_config.capabilities, {
          offsetEncoding = "utf-16",
        }),
      },
      -- volar = {
      --   filetypes = { "vue" },
      -- },
      tailwindcss = {
        settings = {
          tailwindCSS = {
            classFunctions = { "cva", "cx" },
          },
        },
      },
    }

    -- setup lsp
    vim.lsp.config("*", default_config)

    for name, opts in pairs(server_configs) do
      vim.lsp.config(name, opts)
      vim.lsp.enable(name)
    end
  end,
}
