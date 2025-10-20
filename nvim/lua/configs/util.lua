local M = {}

-- 프로젝트 루트를 찾기 위해 rootMarker를 찾는 함수
---@param dir string
---@param rootMarker string
---@return string?
M.find_project_root = function(dir, rootMarker)
  local function search_up(path)
    local package_json = path .. "/" .. rootMarker
    if vim.fn.filereadable(package_json) == 1 then
      return path
    end

    local parent = vim.fn.fnamemodify(path, ":h")
    if parent == path then
      return nil
    end

    return search_up(parent)
  end
  return search_up(dir)
end

-- 프로젝트별 prettier 설정 캐시
local prettier_config_cache = {}

-- Attach to buffer close event to clear cache
vim.api.nvim_create_autocmd("BufDelete", {
  callback = function(args)
    local bufname = vim.api.nvim_buf_get_name(args.buf)
    if prettier_config_cache[bufname] ~= nil then
      prettier_config_cache[bufname] = nil
    end
  end,
})

--- Determines if the current buffer has a Prettier configuration.
--- @param bufnr number The buffer number to check.
--- @return boolean Whether a Prettier configuration exists.
M.has_prettier_config = function(bufnr)
  local current_file = vim.api.nvim_buf_get_name(bufnr)

  if prettier_config_cache[current_file] ~= nil then
    return prettier_config_cache[current_file]
  end

  if current_file == "" then
    return false
  end

  local current_dir = vim.fn.fnamemodify(current_file, ":h")

  -- 프로젝트 루트 찾기
  local project_root = M.find_project_root(current_dir, "package.json")

  if not project_root then
    return false
  end

  -- 캐시에서 확인
  if prettier_config_cache[project_root] ~= nil then
    prettier_config_cache[current_file] = prettier_config_cache[project_root]

    return prettier_config_cache[project_root]
  end

  -- Prettier 설정 파일 목록
  local prettier_configs = {
    "prettier.config.js",
    "prettier.config.cjs",
    "prettier.config.mjs",
    ".prettierrc",
    ".prettierrc.json",
    ".prettierrc.js",
    ".prettierrc.cjs",
    ".prettierrc.mjs",
    ".prettierrc.yaml",
    ".prettierrc.yml",
    ".prettierrc.toml",
  }

  -- 프로젝트 루트에서 prettier 설정 파일 확인
  local has_config = false

  for _, config_file in ipairs(prettier_configs) do
    if vim.fn.filereadable(project_root .. "/" .. config_file) == 1 then
      has_config = true
      break
    end
  end

  -- prettier 설정 파일이 없다면 package.json 내부 확인
  if not has_config then
    local package_json = project_root .. "/package.json"
    local success, package_content = pcall(function()
      local file = io.open(package_json, "r")
      if file then
        local content = file:read("*all")
        file:close()
        return vim.json.decode(content)
      end
      return nil
    end)

    if success and package_content and package_content.prettier then
      has_config = true
    end
  end

  -- 결과를 캐시에 저장
  prettier_config_cache[current_file] = has_config
  prettier_config_cache[project_root] = has_config

  return has_config
end

--- Determines if the current buffer has a Biome configuration.
--- @param bufnr number The buffer number to check.
--- @return boolean Whether a Biome configuration exists.
M.has_biome = function(bufnr)
  local current_file = vim.api.nvim_buf_get_name(bufnr)

  if current_file == "" then
    return false
  end

  local current_dir = vim.fn.fnamemodify(current_file, ":h")

  -- 프로젝트 루트 찾기
  local project_root = M.find_project_root(current_dir, "package.json")

  if not project_root then
    return false
  end

  -- Biome 설정 파일 목록
  local biome_configs = {
    "biome.json",
    "biome.jsonc",
  }

  -- 프로젝트 루트에서 biome 설정 파일 확인
  for _, config_file in ipairs(biome_configs) do
    if vim.fn.filereadable(project_root .. "/" .. config_file) == 1 then
      return true
    end
  end

  return false
end

return M
