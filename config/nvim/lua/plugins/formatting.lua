-- ~/.config/nvim/lua/plugins/formatting.lua
-- conform.nvim: format-on-save using standalone CLI formatters (not the LSP).
-- Formatters used here are already installed on your system:
--   ruff (python), rustfmt (via rustup), stylua (lua).
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      python = { "ruff_organize_imports", "ruff_format" },
      rust = { "rustfmt" },
      lua = { "stylua" },
      fish = { "fish_indent" },
      -- Go (gopls also formats, but goimports handles imports too).
      go = { "goimports", "gofumpt" },
      -- C/C++.
      c = { "clang_format" },
      cpp = { "clang_format" },
      -- Shell.
      sh = { "shfmt" },
      bash = { "shfmt" },
      -- Web / data — prettierd is fast (daemonised prettier).
      javascript = { "prettierd" },
      javascriptreact = { "prettierd" },
      typescript = { "prettierd" },
      typescriptreact = { "prettierd" },
      json = { "prettierd" },
      jsonc = { "prettierd" },
      yaml = { "prettierd" },
      css = { "prettierd" },
      html = { "prettierd" },
      markdown = { "prettierd" },
    },
    format_on_save = function(bufnr)
      -- Allow disabling per-buffer/globally via a variable (see keymap below).
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 1000, lsp_format = "fallback" }
    end,
  },
  init = function()
    -- :FormatToggle to turn format-on-save on/off for the session.
    vim.api.nvim_create_user_command("FormatToggle", function()
      vim.g.disable_autoformat = not vim.g.disable_autoformat
      print("Format on save: " .. (vim.g.disable_autoformat and "OFF" or "ON"))
    end, { desc = "Toggle format-on-save" })
  end,
}
