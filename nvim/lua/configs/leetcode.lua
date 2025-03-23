local M = {}

M.get_leet_arg = function()
  return "leetcode.nvim"
end

M.is_leetcode = function()
  return M.get_leet_arg() == vim.fn.argv(0, -1)
end

return M
