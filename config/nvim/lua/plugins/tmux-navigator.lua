-- Pairs with the tmux-side vim-tmux-navigator plugin (set in tmux.conf).
-- Without this nvim plugin, C-h/j/k/l cannot navigate *out* of an nvim
-- window into an adjacent tmux pane — the tmux plugin handles tmux→nvim,
-- but nvim→tmux requires this side too.
return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
  },
  keys = {
    { "<C-h>", "<cmd>TmuxNavigateLeft<cr>",  desc = "Navigate left (tmux/nvim)" },
    { "<C-j>", "<cmd>TmuxNavigateDown<cr>",  desc = "Navigate down (tmux/nvim)" },
    { "<C-k>", "<cmd>TmuxNavigateUp<cr>",    desc = "Navigate up (tmux/nvim)" },
    { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Navigate right (tmux/nvim)" },
  },
}
