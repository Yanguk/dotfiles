return {
  "saghen/blink.cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  -- optional: provides snippets for the snippet source
  dependencies = {
    "rafamadriz/friendly-snippets",
    "fang2hou/blink-copilot",
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    -- {
    --   "saghen/blink.compat",
    --   config = function()
    --     -- monkeypatch cmp.ConfirmBehavior for Avante
    --     require("cmp").ConfirmBehavior = {
    --       Insert = "insert",
    --       Replace = "replace",
    --     }
    --   end,
    --   lazy = true,
    -- },
  },

  -- use a release tag to download pre-built binaries
  version = "*",
  build = "cargo build --release",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "default",
      -- ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      -- ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
      -- ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      -- ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      -- ["<C-e>"] = { "hide" },
      -- ["<C-y>"] = { "select_and_accept" },
      -- ["<C-p>"] = { "select_prev", "fallback" },
      -- ["<C-n>"] = { "select_next", "fallback" },
      -- ["<Tab>"] = { "snippet_forward", "fallback" },
      -- ["<S-Tab>"] = { "snippet_backward", "fallback" },
      -- ["<Up>"] = { "select_prev", "fallback" },
      -- ["<Down>"] = { "select_next", "fallback" },
    },
    snippets = {
      preset = "luasnip",
    },
    sources = {
      per_filetype = {
        lua = { inherit_defaults = true, "lazydev" },
        -- AvanteInput = {
        --   "avante_commands",
        --   "avante_mentions",
        --   "avante_files",
        -- },
      },
      default = {
        "lsp",
        "path",
        "snippets",
        "buffer",
        "copilot",
      },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
        -- avante_commands = {
        --   name = "avante_commands",
        --   module = "blink.compat.source",
        --   score_offset = 90, -- show at a higher priority than lsp
        --   opts = {},
        -- },
        -- avante_files = {
        --   name = "avante_files",
        --   module = "blink.compat.source",
        --   score_offset = 100, -- show at a higher priority than lsp
        --   opts = {},
        -- },
        -- avante_mentions = {
        --   name = "avante_mentions",
        --   module = "blink.compat.source",
        --   score_offset = 100, -- show at a higher priority than lsp
        --   opts = {},
        -- },
      },
    },
    completion = {
      menu = {
        draw = {
          treesitter = { "lsp" },
        },
      },
      documentation = {
        auto_show = true,
      },
    },
  },
}
