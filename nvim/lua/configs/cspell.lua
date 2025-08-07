local M = {}

function M.get_cspell_path()
  return vim.fn.expand("$HOME/.config/cspell/cspell.json")
end

function M.get_dictionary_path()
  return vim.fn.expand("$HOME/.config/cspell/my-dictionary.txt")
end

-- Add unknown word under cursor to dictionary
function M.add_word_to_c_spell_dictionary()
  local word = vim.fn.expand("<cword>")

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
