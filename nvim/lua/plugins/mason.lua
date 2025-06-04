return {
  "mason-org/mason.nvim",
  lazy = false,
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
}
