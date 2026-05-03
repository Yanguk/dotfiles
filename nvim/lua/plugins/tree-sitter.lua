return {
  "nvim-treesitter/nvim-treesitter",
  version = "*",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  build = ":TSUpdate",
  config = function()
    -- install-swift-parser.sh 로 설치한 커스텀 swift 파서 등록
    local swift_parser = vim.fn.stdpath("config") .. "/parser/swift.so"

    if vim.uv.fs_stat(swift_parser) then
      vim.treesitter.language.add("swift", { path = swift_parser })
    else
      local install_script = vim.fn.stdpath("config") .. "/scripts/install-swift-parser.sh"

      vim.notify("[swift-parser] 파서가 없습니다. 설치 중...", vim.log.levels.INFO)
      vim.system({ "bash", install_script }, { text = true }, function(result)
        if result.code == 0 then
          vim.schedule(function()
            vim.treesitter.language.add("swift", { path = swift_parser })
            vim.notify("[swift-parser] 설치 완료", vim.log.levels.INFO)
          end)
        else
          vim.schedule(function()
            vim.notify("[swift-parser] 설치 실패:\n" .. (result.stderr or ""), vim.log.levels.ERROR)
          end)
        end
      end)

      vim.treesitter.language.add("swift", { path = swift_parser })
    end

    require("nvim-treesitter.configs").setup({
      ensure_installed = { "lua", "luadoc", "printf", "vim", "vimdoc", "html" },
      ignore_install = { "dockerfile", "swift" },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    })
  end,
}
