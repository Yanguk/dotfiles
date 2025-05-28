return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {},
  config = function()
    local npairs = require("nvim-autopairs")
    npairs.setup()

    local Rule = require("nvim-autopairs.rule")
    local cond = require("nvim-autopairs.conds")

    npairs.remove_rule("[")
    npairs.add_rule(Rule("[", "]"):with_pair(cond.not_filetypes({ "markdown" })))
  end,
}
