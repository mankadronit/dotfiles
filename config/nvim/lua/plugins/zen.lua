-- ~/.config/nvim/lua/plugins/zen.lua
-- Distraction-free coding (adopted from radleylewis/nvim). zen-mode centres the
-- buffer; twilight dims everything outside the section you're editing.
return {
  "folke/zen-mode.nvim",
  dependencies = { "folke/twilight.nvim", opts = {} },
  cmd = "ZenMode",
  keys = {
    { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen mode" },
  },
  opts = {
    window = { width = 0.85, options = { number = false, relativenumber = false } },
    plugins = { twilight = { enabled = true } },
  },
}
