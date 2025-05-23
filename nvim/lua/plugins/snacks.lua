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
        { section = "recent_files", limit = 8, padding = 1 },
        { title = "Bookmarks", padding = 1 },
        { section = "keys" },
      },
      formats = {
        key = function(item)
          return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
        end,
      },
    },
    -- explorer = { enabled = true },
    image = { enabled = true },
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
    input = { enabled = true },
    picker = { enabled = true },
    -- lazygit = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    -- scope = { enabled = true },
    -- scroll = { enabled = true },
    statuscolumn = { enabled = true },
    -- words = { enabled = true },
  },
  keys = {
    -- picker
    {
      "<leader><space>",
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
  },
}
