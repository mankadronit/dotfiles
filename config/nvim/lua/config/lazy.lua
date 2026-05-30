-- ~/.config/nvim/lua/config/lazy.lua
-- Bootstrap lazy.nvim (the plugin manager) and load every spec in lua/plugins/.

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", repo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- Import every file under lua/plugins/ as a plugin spec.
    { import = "plugins" },
  },
  install = { colorscheme = { "tokyonight" } },
  -- Check for plugin updates in the background, but don't notify on every start.
  checker = { enabled = true, notify = false },
  change_detection = { notify = false },
  ui = { border = "rounded" },
})

-- Quick access to the plugin manager UI.
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Lazy (plugin manager)" })
