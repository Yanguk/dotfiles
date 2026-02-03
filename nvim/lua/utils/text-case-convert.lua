local M = {}

M.cycle_case_style = function()
  -- 현재 줄/커서
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()

  -- 커서 기준 전체 단어 범위 찾기 (a-z, A-Z, 0-9, -, _)
  local left = col
  while left > 0 and line:sub(left, left):match("[%w%-_]") do
    left = left - 1
  end

  local right = col + 1
  while right <= #line and line:sub(right, right):match("[%w%-_]") do
    right = right + 1
  end

  local word = line:sub(left + 1, right - 1)
  if word == "" then
    vim.notify("No word under cursor", vim.log.levels.WARN)
    return
  end

  local new_word

  -- 1) kebab-case -> camelCase
  if word:find("-", 1, true) then
    new_word = word:gsub("-(%l)", function(c)
      return c:upper()
    end)

  -- 2) camelCase -> snake_case
  elseif word:match("%l%u") then
    new_word = word
      :gsub("(%l)(%u)", "%1_%2")
      :lower()

  -- 3) snake_case (또는 기타) -> kebab-case
  else
    new_word = word:gsub("_", "-")
  end

  -- 결과가 동일하면 (예: 이미 kebab인데 변환 결과가 같으면) snake로 강제
  if new_word == word then
    new_word = word:gsub("_", "-")
  end

  -- 단어 교체
  vim.api.nvim_buf_set_text(
    0,
    row - 1,
    left,
    row - 1,
    right - 1,
    { new_word }
  )
end

return M
