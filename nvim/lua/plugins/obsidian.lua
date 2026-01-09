return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- use latest release, remove to use latest commit
  ft = "markdown",
  cmd = "Obsidian",
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false,
    ui = { enable = false },
    workspaces = {
      {
        name = "personal",
        path = "~/vaults/yanguk",
      },
    },
    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "calendar",
      -- date_format = "%Y-%m-%d",
      -- -- Optional, if you want to change the date format of the default alias of daily notes.
      -- alias_format = "%B %-d, %Y",
      -- -- Optional, default tags to add to each new daily note created.
      -- default_tags = { "daily-notes" },
      -- -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      -- template = nil,
    },
    notes_subdir = "scratch",
    -- see below for full list of options 👇
  },
  -- init = function()
  --   vim.opt.conceallevel = 1
  -- end,
}
