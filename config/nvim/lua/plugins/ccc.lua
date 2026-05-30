-- ~/.config/nvim/lua/plugins/ccc.lua
-- Colour picker + inline colour highlighting (adopted from radleylewis/nvim).
-- Highlights #rrggbb / rgb() / hsl() in place; <leader>cp opens an interactive
-- picker. Lives under the existing <leader>c (code) prefix.
return {
  "uga-rosa/ccc.nvim",
  cmd = { "CccPick", "CccHighlighterToggle", "CccConvert" },
  keys = {
    { "<leader>cp", "<cmd>CccPick<cr>", desc = "Colour picker" },
    { "<leader>cH", "<cmd>CccHighlighterToggle<cr>", desc = "Toggle colour highlight" },
  },
  opts = {
    highlighter = {
      auto_enable = true,
      lsp = true, -- pick up colours reported by LSP (e.g. tailwind, css)
    },
  },
}
