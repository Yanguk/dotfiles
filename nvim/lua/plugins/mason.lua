local ensure_installed = {
  "copilot-language-server",
  "clangd",
  "zls",
  "bash-language-server",
  "copilot-language-server",
  "docker-compose-language-service",
  "dockerfile-language-server",
  "eslint-lsp",
  "graphql-language-service-cli",
  "lua-language-server",
  "nil",
  "prettierd",
  "prisma-language-server",
  -- "python-lsp-server",
  "rust-analyzer",
  "shfmt",
  "stylua",
  "tailwindcss-language-server",
  "taplo",
  "terraform-ls",
  "typescript-language-server",
  "typos-lsp",
  "yaml-language-server",
  "yamlfmt",
}

return {
  "mason-org/mason.nvim",
  cmd = { "Mason", "MasonInstallAll", "MasonUpdate", "MasonInstall", "MasonUninstall" },
  opts = {
    ui = {
      border = "rounded",
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  },
  config = function(_, opts)
    local mason = require("mason")
    mason.setup(opts)

    vim.api.nvim_create_user_command("MasonInstallAll", function()
      local registry = require("mason-registry")
      local to_install = {}

      for _, pkg_name in ipairs(ensure_installed) do
        if not registry.is_installed(pkg_name) then
          table.insert(to_install, pkg_name)
        end
      end

      if #to_install > 0 then
        local packages = table.concat(to_install, " ")
        vim.notify("Installing " .. #to_install .. " packages: " .. packages, vim.log.levels.INFO)
        vim.cmd("MasonInstall " .. packages)
      else
        vim.notify("All packages are already installed!", vim.log.levels.INFO)
      end
    end, {})
  end,
}
