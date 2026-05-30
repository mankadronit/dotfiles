-- ~/.config/nvim/lua/config/options.lua
-- Sensible editor defaults. `:h option-list` documents every one of these.

local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true -- relative numbers make j/k motions easy

-- Mouse + clipboard
opt.mouse = "a"
-- Sync with the system clipboard. Scheduled so it doesn't slow startup.
vim.schedule(function()
  opt.clipboard = "unnamedplus"
end)

-- Indentation (2 spaces by default; filetypes can override)
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true -- case-sensitive only if the query has a capital
opt.hlsearch = true
opt.incsearch = true

-- UI
opt.termguicolors = true
opt.signcolumn = "yes" -- always show the sign column to avoid text shifting
opt.cursorline = true
opt.scrolloff = 10 -- keep 10 lines of context above/below the cursor
opt.wrap = false
opt.splitright = true -- new vertical splits go to the right
opt.splitbelow = true -- new horizontal splits go below
opt.inccommand = "split" -- live preview of :substitute
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Files / undo
opt.undofile = true -- persistent undo across sessions
opt.swapfile = false

-- Performance / behaviour
opt.updatetime = 250 -- faster CursorHold (used by LSP / diagnostics)
opt.timeoutlen = 400 -- which-key popup delay
opt.confirm = true -- ask to save instead of failing on :q with changes
