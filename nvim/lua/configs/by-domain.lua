local M = {}

M.isDisableAutoFormatBuf = function(bufnr)
  local bufname = vim.api.nvim_buf_get_name(bufnr)

  local patterns = { "tooling", "server%-common" }

  for _, pattern in ipairs(patterns) do
    if bufname:find(pattern) then
      return true
    end
  end

  return false
end

return M
