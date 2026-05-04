local treesitter = require("nvim-treesitter")
local installing_languages = {}
local available_languages = {}

for _, lang in ipairs(treesitter.get_available()) do
  available_languages[lang] = true
end

local function enable_treesitter(bufnr, lang)
  pcall(vim.treesitter.start, bufnr, lang)
  vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

local function install_parser(bufnr, filetype, opts)
  if filetype == "" or vim.bo[bufnr].buftype ~= "" then
    return
  end

  opts = opts or {}

  local lang = vim.treesitter.language.get_lang(filetype) or filetype
  if not available_languages[lang] then
    return
  end

  local installed = treesitter.get_installed()

  if vim.tbl_contains(installed, lang) then
    enable_treesitter(bufnr, lang)
    return
  end

  if installing_languages[lang] then
    return
  end

  if opts.confirm ~= false then
    local choice = vim.fn.confirm(
      string.format("treesitter parser '%s' is not installed. Install it now?", lang),
      "&Yes\n&No",
      1
    )

    if choice ~= 1 then
      return
    end
  end

  installing_languages[lang] = true

  treesitter
    .install({ lang }, { summary = true })
    :await(function(err, ok)
      installing_languages[lang] = nil

      if err or not ok then
        vim.schedule(function()
          vim.notify(
            string.format("Failed to install treesitter parser '%s'", lang),
            vim.log.levels.ERROR
          )
        end)
        return
      end

      vim.schedule(function()
        vim.notify(string.format("Installed treesitter parser '%s'", lang), vim.log.levels.INFO)

        if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].filetype == filetype then
          enable_treesitter(bufnr, lang)
        end
      end)
    end)
end

-- local function maybe_install_parser(bufnr, filetype)
--   install_parser(bufnr, filetype, { confirm = true })
-- end

local function auto_install_parser(bufnr, filetype)
  install_parser(bufnr, filetype, { confirm = false })
end

return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "main",
  build = ":TSUpdate",
  init = function()
    local group = vim.api.nvim_create_augroup("user_treesitter_install_prompt", { clear = true })

    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      callback = function(args)
        -- maybe_install_parser(args.buf, args.match)
        auto_install_parser(args.buf, args.match)
      end,
    })
  end,
}
