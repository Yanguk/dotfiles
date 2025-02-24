local byDomain = require("configs.by-domain")

local command = vim.api.nvim_create_user_command

command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})

command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Enable autoformat-on-save",
})

return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },

      javascript = {
        "prettierd",
      },
      typescript = {
        "prettierd",
      },
      javascriptreact = {
        "prettierd",
      },
      typescriptreact = {
        "prettierd",
      },
      markdown = { "prettierd" },
      html = { "prettierd" },
      json = { "prettierd" },
      jsonc = { "prettierd" },

      -- racket = { "raco" },
      sh = { "shfmt" },
      -- rust = { "rustfmt" }, @deprecated
      -- c = { "clang_format" },

      toml = { "taplo" },
      yaml = { "yamlfmt" },
      zig = { "zigfmt" },
      nix = { "nixfmt" },
      terraform = { "terraform_fmt" },
    },
    format_on_save = function(bufnr)
      -- 해당 프로젝트는 eslint로 포멧
      if byDomain.isDisableAutoFormatBuf(bufnr) then
        return
      end

      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      return { timeout_ms = 1000, lsp_format = "fallback" }
    end,
  },
  event = { "BufWritePre" },
  cmd = { "ConformInfo", "Format" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>fm",
      "<cmd>Format<cr>",
      mode = "",
      desc = "Format buffer",
    },
  },
  dependencies = {
    "williamboman/mason.nvim",
    "zapling/mason-conform.nvim",
  },
  config = function(_, opts)
    command("Format", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end
      require("conform").format({ async = true, lsp_format = "fallback", range = range })
    end, { range = true })

    require("conform").setup(opts)
    require("mason-conform").setup()
  end,
}
