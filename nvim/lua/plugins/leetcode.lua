local leetcode_config = require("configs.leetcode")

return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
  -- cmd = "Leet",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  lazy = not leetcode_config.is_leetcode(),
  opts = {
    arg = leetcode_config.get_leet_arg(),
    -- image_support = true, 활성화시 문제 wrap이 비활성화됨.
    lang = "rust",
    injector = {
      ---@type table<lc.lang, lc.inject>
      ["rust"] = {
        before = { "#![allow(dead_code)]", "fn main(){}", "struct Solution;" },
      },
    },
    hooks = {
      ---@type fun(question: lc.ui.Question)[]
      ["question_enter"] = {
        function(question)
          local problem_dir = vim.fn.stdpath("data") .. "/leetcode/Cargo.toml"
          local content = [[
            [package]
            name = "leetcode"
            edition = "2024"

            [lib]
            name = "%s"
            path = "%s"
          ]]

          local file = io.open(problem_dir, "w")

          if file then
            local formatted = (content:gsub(" +", "")):format(question.q.frontend_id, question:path())
            file:write(formatted)
            file:close()
          else
            print("Failed to open file: " .. problem_dir)
          end
        end,
      },
    },
  },
}
