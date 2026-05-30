-- ~/.config/nvim/lua/plugins/mason-tools.lua
-- Declaratively ensure the standalone formatters/linters/debuggers are installed
-- via Mason (the LSP *servers* are handled by mason-lspconfig in lsp.lua).
-- Mason puts these on nvim's PATH, so conform.nvim (formatting.lua) finds them.
return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = { "mason-org/mason.nvim" },
  event = "VeryLazy",
  opts = {
    ensure_installed = {
      "prettierd", -- ts/js/json/yaml/css/html/markdown formatter
      "shfmt", -- shell formatter
      "clang-format", -- c/c++ formatter
      "codelldb", -- rust/c/c++ debug adapter (keeps it declarative)
      -- Go formatters (gofumpt, goimports) are omitted until the Go toolchain
      -- is installed (`brew install go`); add them back here afterwards.
    },
    run_on_start = true,
  },
}
