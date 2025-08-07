---@diagnostic disable: undefined-global
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    bufdelete = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        header = [[
 ／|_      
(o o /     
 |.   ~.   
 じしf_,)ノ]],
        -- keys = {
        --   -- { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
        --   -- { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        -- },
      },
      sections = {
        { section = "header" },
        { title = "MRU", padding = 1 },
        { section = "recent_files", cwd = true, limit = 10, padding = 1 },
        { title = "Bookmarks", padding = 1 },
        { section = "keys", padding = 2 },
        { section = "startup" },
      },
      formats = {
        key = function(item)
          return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
        end,
      },
    },
    -- explorer = { enabled = true },
    image = {
      enabled = true,
      doc = {
        -- in .css, issue
        enabled = false,
      },
    },
    indent = {
      enabled = true,
      indent = {
        char = "▏",
      },
      animate = {
        enabled = false,
      },
      scope = {
        enabled = false,
        char = "▏",
      },
    },
    input = {
      enabled = true,
      relative = "cursor",
    },
    picker = { enabled = true },
    lazygit = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    terminal = { enabled = true },
    zen = {
      enabled = true,
      -- toggles = {
      --   dim = false,
      -- },
    },
    -- words = { enabled = true },
    styles = {
      input = {
        relative = "cursor",
        row = -3,
      },
    },
  },
  keys = {
    -- lazygit
    {
      "<leader>lg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit",
    },
    -- picker
    {
      "<leader>fs",
      function()
        Snacks.picker.smart()
      end,
      desc = "Smart Find Files",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "Find Files",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.git_files()
      end,
      desc = "Find Git Files",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.recent()
      end,
      desc = "Recent",
    },
    {
      "<leader>fw",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>gs",
      function()
        Snacks.picker.git_status()
      end,
      desc = "Git Status",
    },
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffers",
    },
    -- buffer
    {
      "<leader>x",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete Buffer",
    },
    {
      "<leader>X",
      function()
        Snacks.bufdelete.other()
      end,
      desc = "Delete other buffers",
    },
    -- term
    {
      [[<c-\>]],
      function()
        Snacks.terminal()
      end,
      desc = "Toggle Terminal",
      mode = { "t", "n" },
    },
    {
      "<c-x>",
      [[<C-\><C-n>]],
      mode = { "t" },
      desc = "exit Terminal",
    },
    -- zen
    {
      "<leader>z",
      function()
        Snacks.zen()
      end,
      desc = "Toggle Zen Mode",
    },
    {
      "<leader>Z",
      function()
        Snacks.zen.zoom()
      end,
      desc = "Toggle Zoom",
    },
  },
}
