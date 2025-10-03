return {
  {
    "nvim-mini/mini.icons",
    version = "*",
    opts = {
      extension = {
        ["mdx"] = { glyph = "", hl = "MiniIconsOrange" },
      },
    },
    lazy = true,
    specs = {
      { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  {
    -- for codecompanion
    "nvim-mini/mini.diff",
    enabled = false,
    event = "VeryLazy",
    config = function()
      local diff = require("mini.diff")
      diff.setup({
        -- Disabled by default
        source = diff.gen_source.none(),
      })
    end,
  },
  { "nvim-mini/mini.trailspace", version = false, opts = {}, event = "BufReadPost" },
}
