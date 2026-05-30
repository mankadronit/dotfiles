-- ~/.config/nvim/lua/plugins/markdown.lua
-- Live markdown preview in the browser (adopted from radleylewis/nvim).
-- The build step downloads a prebuilt server (needs node, which you have).
return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
  ft = "markdown",
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  keys = {
    { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown preview toggle" },
  },
}
