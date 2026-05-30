-- ~/.config/nvim/init.lua
-- Entry point. Keep this tiny: set the leader, then load core + plugins.

-- Leader MUST be set before lazy.nvim loads so plugin keymaps pick it up.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Use a Nerd Font (set to false if your terminal font has no icons).
vim.g.have_nerd_font = true

require("config.options") -- editor settings
require("config.keymaps") -- non-plugin keymaps
require("config.lazy") -- bootstrap plugin manager + load lua/plugins/*
