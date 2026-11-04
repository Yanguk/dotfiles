return {
  "sammaji/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  opts = {
    browser = { "open", "-a", "Google Chrome" },
  },
}
