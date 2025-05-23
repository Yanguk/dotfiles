-- cSpell:disable
local map = vim.keymap.set

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })
map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "file save" })
map("n", ";", ":", { desc = "CMD enter command mode" })
map("v", ";", ":", { desc = "CMD enter command mode" })

-- Trailing Space 플러그인 관련 매핑
map(
  "n",
  "<leader>ts",
  (function()
    local isHighlightEnabled = false

    return function()
      if isHighlightEnabled then
        vim.cmd("highlight clear ExtraWhitespace")
        vim.cmd("match none")
      else
        vim.cmd("highlight ExtraWhitespace ctermbg=red guibg=red")
        vim.cmd("match ExtraWhitespace /\\s\\+$/")
      end

      isHighlightEnabled = not isHighlightEnabled
    end
  end)(),
  { desc = "[T]oggle trailing [S]pace" }
) -- 뒤에 공백 토글

-- resize window
map("n", "<A-=>", ":vertical resize +5<CR>", { silent = true }) -- make the window bigger  vertically
map("n", "<A-->", ":vertical resize -5<CR>", { silent = true }) -- make the window smaller vertically
map("n", "<A-+>", ":resize +2<CR>", { silent = true }) -- make the window bigger horizontally by pressing shift and =
map("n", "<A-_>", ":resize -2<CR>", { silent = true }) -- make the window smaller horizontally by pressing shift and -
