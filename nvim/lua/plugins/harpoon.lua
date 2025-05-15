return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  enabled = false,
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "HarpoonAdd", "HarpoonMenu" },
  config = function(_, opts)
    require("harpoon").setup(opts)

    vim.api.nvim_create_user_command("HarpoonAdd", function()
      require("harpoon"):list():add()
    end, {
      desc = "Add current file to harpoon",
    })

    vim.api.nvim_create_user_command("HarpoonMenu", function()
      require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
    end, {
      desc = "Toggle harpoon menu",
    })
  end,
  keys = {
    {
      "<A-1>",
      function()
        require("harpoon"):list():select(1)
      end,
      desc = "harpoon select 1",
    },
    {
      "<A-2>",
      function()
        require("harpoon"):list():select(2)
      end,
      desc = "harpoon select 2",
    },
    {
      "<A-3>",
      function()
        require("harpoon"):list():select(3)
      end,
      desc = "harpoon select 3",
    },
    {
      "<A-4>",
      function()
        require("harpoon"):list():select(4)
      end,
      desc = "harpoon select 4",
    },
  },
}
