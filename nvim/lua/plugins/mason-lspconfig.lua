return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "LspInfo", "LspInstall", "LspUninstall" },
  dependencies = {
    "saghen/blink.cmp",

    -- mason
    { "williamboman/mason.nvim", cmd = "Mason", opts = {} },
    "williamboman/mason-lspconfig.nvim",

    -- rust
    {
      "mrcjkb/rustaceanvim",
      version = "*", -- Recommended
      lazy = false, -- This plugin is already lazy
    },

    -- ts-tools
    "pmizio/typescript-tools.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("mason-lspconfig").setup({
      automatic_installation = true,
      ensure_installed = { "ts_ls", "rust_analyzer" },
    })

    local default_config = {
      capabilities = require("blink.cmp").get_lsp_capabilities(),
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

    -- nvim-ufo (ts 에서 배열을 폴드할려면 lsp로 해야함)
    default_config.capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    local server_configs = {
      lua_ls = {},
      zls = {},
      yamlls = {},
      graphql = {},
      prismals = {},
      docker_compose_language_service = {},
      dockerls = {},
      nil_ls = {},
      terraformls = {},
      pylsp = {},
      typos_lsp = {
        init_options = {
          config = "~/.config/nvim/typos.toml",
        },
      },
      eslint = {
        on_attach = function(client, bufnr)
          default_config.on_attach(client, bufnr)

          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
        root_markers = {
          "eslint.config.js",
          "eslint.config.mjs",
          "eslint.config.cjs",
          "eslint.config.ts",
          "eslint.config.mts",
          "eslint.config.cts",
          ".eslintrc.js",
          ".eslintrc",
          ".eslintrc.cjs",
          ".eslintrc.yaml",
          ".eslintrc.yml",
          ".eslintrc.json",
        },
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
            experimental = {
              classRegex = {
                "cva\\(([^)]*)\\)",
                "[\"'`]([^\"'`]*).*?[\"'`]",
              },
            },
          },
        },
      },
    }

    -- setup lspconfig
    vim.lsp.config("*", default_config)

    for name, opts in pairs(server_configs) do
      vim.lsp.enable(name)
      vim.lsp.config(name, opts)
    end

    vim.g.rustaceanvim = {
      server = {
        on_init = default_config.on_init,
        on_attach = default_config.on_attach,
        capabilities = default_config.capabilities,
      },
    }

    require("typescript-tools").setup({
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
    })
  end,
}
