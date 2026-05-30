-- ~/.config/nvim/lua/plugins/trouble.lua
-- A pretty list for diagnostics, references, symbols and quickfix
-- (adopted from radleylewis/nvim). Lives under the <leader>x prefix.
return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  opts = {},
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
    { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols" },
    { "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP defs/refs" },
    { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location list" },
    { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
  },
}
