-- ~/.config/nvim/lua/plugins/obsidian.lua
-- Obsidian vault integration (adopted from radleylewis/nvim). Uses the actively
-- maintained fork and the snacks picker you already have. Notes live in
-- ~/Documents/Notes by default — change `path` below to your real vault.
-- Keymaps live under <leader>o.
return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  ft = "markdown",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>on", "<cmd>Obsidian new<cr>", desc = "New note" },
    { "<leader>oo", "<cmd>Obsidian quick_switch<cr>", desc = "Quick switch" },
    { "<leader>os", "<cmd>Obsidian search<cr>", desc = "Search notes" },
    { "<leader>ot", "<cmd>Obsidian today<cr>", desc = "Today's daily note" },
    { "<leader>ob", "<cmd>Obsidian backlinks<cr>", desc = "Backlinks" },
  },
  opts = {
    workspaces = {
      { name = "notes", path = "~/Documents/Notes" },
    },
    completion = { blink = true, min_chars = 2 },
    picker = { name = "snacks.pick" },
    ui = { enable = false }, -- let your markdown highlighting/treesitter own rendering
  },
}
