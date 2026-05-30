-- ~/.config/nvim/lua/plugins/snacks.lua
-- snacks.nvim is folke's all-in-one QoL collection. We use it for the fuzzy
-- picker (replaces telescope) and the file explorer (replaces neo-tree),
-- plus a handful of small niceties. One plugin instead of five.
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true }, -- disable heavy features in huge files
    explorer = { enabled = true }, -- file tree (opened via the picker below)
    indent = { enabled = true }, -- indent guides
    input = { enabled = true }, -- prettier vim.ui.input
    notifier = { enabled = true }, -- notifications
    picker = { enabled = true }, -- the fuzzy finder
    quickfile = { enabled = true }, -- render the file before plugins load
    scope = { enabled = true }, -- treesitter-aware scope text objects
    statuscolumn = { enabled = true },
    words = { enabled = true }, -- highlight references under cursor
  },
  keys = {
    -- Find
    { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart find files" },
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
    { "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep (live)" },
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Find buffers" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent files" },
    { "<leader>fw", function() Snacks.picker.grep_word() end, desc = "Grep word under cursor", mode = { "n", "x" } },
    { "<leader>fh", function() Snacks.picker.help() end, desc = "Help pages" },
    { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>fd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command history" },
    -- Explorer / tree
    { "<leader>ee", function() Snacks.explorer() end, desc = "Toggle file explorer" },
    { "<leader>E", function() Snacks.explorer() end, desc = "File explorer" },
    -- Git
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git branches" },
    { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git log" },
    { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Open in browser", mode = { "n", "x" } },
    -- Misc
    { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notification history" },
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete buffer" },
    { "<c-/>", function() Snacks.terminal() end, desc = "Toggle terminal" },
  },
}
