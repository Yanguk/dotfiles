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
      pyright = {
        before_init = function(_, config)
          local python_path = vim.fn.trim(vim.fn.system("uv python find 2>/dev/null"))

          if python_path ~= "" and vim.fn.executable(python_path) == 1 then
            config.settings = config.settings or {}
            config.settings.python = config.settings.python or {}
            config.settings.python.pythonPath = python_path
          end
        end,
      },
      codebook = {},
      biome = {},
      kotlin_lsp = {},
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
      sourcekit = {},
    }

    -- setup lsp
    vim.lsp.config("*", default_config)

    for name, opts in pairs(server_configs) do
      vim.lsp.config(name, opts)
      vim.lsp.enable(name)
    end
  end,
}
