return {
  "3rd/image.nvim",
  enabled = false, -- ueberzug 이슈있음 https://github.com/3rd/image.nvim/issues/273
  build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
  opts = {
    backend = "ueberzug",
    processor = "magick_cli",
    window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
    window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
  },
}
