-- ~/.config/nvim/lua/plugins/colorscheme.lua
-- Colorscheme. tokyonight is a fast, well-maintained theme with great
-- treesitter + LSP highlight support.
return {
  "folke/tokyonight.nvim",
  lazy = false, -- load during startup since it's the main UI
  priority = 1000, -- load before other plugins
  config = function()
    require("tokyonight").setup({
      style = "night", -- night | storm | moon | day
    })
    vim.cmd.colorscheme("tokyonight")
  end,
}
