local M = {}

function M.get_cspell_path()
  return vim.fn.expand("$HOME/.config/cspell/cspell.json")
end

return M
