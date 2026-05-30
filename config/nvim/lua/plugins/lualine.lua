-- ~/.config/nvim/lua/plugins/lualine.lua
-- Statusline.
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    options = {
      theme = "tokyonight",
      globalstatus = true, -- one statusline for all windows
      component_separators = "|",
      section_separators = "",
    },
  },
}
