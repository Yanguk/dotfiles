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
        codecompanion = { "codecompanion" },
      },
      default = {
        "lsp",
        "path",
        "snippets",
        "buffer",
        "copilot",
        "lazydev",
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
      },
    },
    completion = {
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
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
