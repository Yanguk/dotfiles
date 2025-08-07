local M = {}

function M.get_cspell_path()
  return vim.fn.expand("$HOME/.config/cspell/cspell.json")
end

function M.get_dictionary_path()
  return vim.fn.expand("$HOME/.config/cspell/my-dictionary.txt")
end

function M.add_word_to_c_spell_dictionary()
  -- Get diagnostics source and only get from cspell
  local bufnr = vim.api.nvim_get_current_buf()
  local winnr = vim.api.nvim_get_current_win()
  local cursor = vim.api.nvim_win_get_cursor(winnr)

  local diagnostics = vim.diagnostic.get(bufnr, { lnum = cursor[1] - 1 })
  local cspell_diagnostics = {}
  for _, diagnostic in ipairs(diagnostics) do
    if diagnostic.source == "cspell" then
      table.insert(cspell_diagnostics, diagnostic)
    end
  end

  -- Check if there are any cspell diagnostics
  if #cspell_diagnostics == 0 then
    vim.notify("No cSpell diagnostics found on current line", vim.log.levels.WARN, { title = "cSpell" })
    return
  end

  -- Get the first word from the first cspell diagnostic
  -- E.g. "Unknown word ( word )"
  local word = cspell_diagnostics[1].message:match("%((.+)%)")
  if word == nil then
    vim.notify("Could not find unknown word", vim.log.levels.WARN, { title = "cSpell" })
    return
  end

  -- Show popup to confirm the action
  local confirm = vim.fn.confirm("Add '" .. word .. "' to cSpell dictionary?", "&Yes\n&No", 2)
  if confirm ~= 1 then
    return
  end

  -- Append the word to the dictionary file
  local file = io.open(M.get_dictionary_path(), "a")

  if file then
    -- Check if file is empty or doesn't end with newline
    local current_pos = file:seek("end")
    local needs_newline = false

    if current_pos > 0 then
      file:seek("end", -1)
      local last_char = file:read(1)
      if last_char and last_char ~= "\n" then
        needs_newline = true
      end
      file:seek("end")
    end

    if needs_newline then
      file:write("\n")
    end

    file:write(word .. "\n")
    file:close()
    -- Reload buffer to update the dictionary
    vim.cmd("e!")
  else
    vim.notify("Could not open cSpell dictionary", vim.log.levels.WARN, { title = "cSpell" })
  end
end

return M
