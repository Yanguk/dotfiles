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
      version = "^5", -- Recommended
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

    local lspconfig = require("lspconfig")

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

    local default_servers = {
      "lua_ls",
      "zls",
      "yamlls",
      "tailwindcss",
      "graphql",
      "prismals",
      "docker_compose_language_service",
      "dockerls",
      "nil_ls",
      "terraformls",
      "pylsp",
    }

    for _, server in pairs(default_servers) do
      lspconfig[server].setup(default_config)
    end

    -- https://eslint.org/docs/user-guide/configuring/configuration-files#configuration-file-formats
    local eslint_root_file = {
      "eslint.config.js",
      ".eslintrc.js",
      ".eslintrc",
      ".eslintrc.cjs",
      ".eslintrc.yaml",
      ".eslintrc.yml",
      ".eslintrc.json",
      "eslint.config.mjs",
      "eslint.config.cjs",
      "eslint.config.ts",
      "eslint.config.mts",
      "eslint.config.cts",
    }

    local server_configs = {
      ["typos_lsp"] = {
        init_options = {
          config = "~/.config/nvim/typos.toml",
        },
      },
      ["eslint"] = {
        on_attach = function(client, bufnr)
          default_config.on_attach(client, bufnr)

          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
        root_dir = function(fname)
          return lspconfig.util.root_pattern(
            unpack(lspconfig.util.insert_package_json(eslint_root_file, "eslintConfig", fname))
          )(fname)
        end,
      },
      ["bashls"] = {
        filetypes = { "sh", "zsh", "bash" },
      },
      ["clangd"] = {
        capabilities = {
          offsetEncoding = "utf-16",
        },
      },
      ["denols"] = {
        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
      },
    }

    for server, config in pairs(server_configs) do
      lspconfig[server].setup(vim.tbl_deep_extend("force", default_config, config))
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
      },
      root_dir = lspconfig.util.root_pattern("package.json"),
      single_file_support = false,
    })
  end,
}
