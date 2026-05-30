-- ~/.config/nvim/lua/plugins/mini.lua
-- A few small, dependency-free modules from mini.nvim.
return {
  "echasnovski/mini.nvim",
  version = false,
  event = "VeryLazy",
  config = function()
    -- Auto-insert matching brackets/quotes.
    require("mini.pairs").setup()
    -- Add/delete/replace surroundings: sa (add), sd (delete), sr (replace).
    require("mini.surround").setup()
    -- Better around/inside text objects: e.g. `va)`, `ci'`, `cif` (function).
    require("mini.ai").setup({ n_lines = 500 })
    -- Move lines/selections with Alt + h/j/k/l (normal + visual).
    require("mini.move").setup()
    -- Highlight all occurrences of the word under the cursor.
    require("mini.cursorword").setup()
  end,
}
