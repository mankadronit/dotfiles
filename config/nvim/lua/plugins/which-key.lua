-- ~/.config/nvim/lua/plugins/which-key.lua
-- Shows a popup of available keybindings as you type a prefix (e.g. <leader>).
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",
    spec = {
      { "<leader>f", group = "find" },
      { "<leader>e", group = "explorer" },
      { "<leader>g", group = "git" },
      { "<leader>c", group = "code" },
      { "<leader>b", group = "buffer" },
      { "<leader>d", group = "debug" },
      { "<leader>x", group = "diagnostics/trouble" },
      { "<leader>r", group = "rust/run" },
      { "<leader>o", group = "obsidian" },
      { "<leader>m", group = "markdown" },
    },
  },
  keys = {
    {
      "<leader>?",
      function() require("which-key").show({ global = false }) end,
      desc = "Buffer local keymaps",
    },
  },
}
