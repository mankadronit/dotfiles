-- ~/.config/nvim/lua/plugins/rust.lua
-- rustaceanvim: the modern Rust experience (adopted from radleylewis/nvim).
-- It OWNS rust-analyzer entirely — do NOT also enable rust_analyzer via
-- mason-lspconfig (that's been removed from lua/plugins/lsp.lua). It also wires
-- up debugging through nvim-dap + codelldb automatically.
--
-- Extra Rust keymaps (buffer-local, Rust files only):
--   <leader>ca  -> RustLsp code actions (grouped)
--   <leader>rd  -> RustLsp debuggables
--   <leader>rr  -> RustLsp runnables
--   K           -> RustLsp hover actions (press K again to enter the popup)
return {
  "mrcjkb/rustaceanvim",
  version = "^6",
  lazy = false, -- the plugin lazy-loads itself on Rust filetypes
  init = function()
    vim.g.rustaceanvim = {
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = true,
            check = { command = "clippy" },
          },
        },
        on_attach = function(_, bufnr)
          local map = function(keys, fn, desc)
            vim.keymap.set("n", keys, fn, { buffer = bufnr, desc = "Rust: " .. desc })
          end
          map("<leader>ca", function() vim.cmd.RustLsp("codeAction") end, "Code action")
          map("K", function() vim.cmd.RustLsp({ "hover", "actions" }) end, "Hover actions")
          map("<leader>rr", function() vim.cmd.RustLsp("runnables") end, "Runnables")
          map("<leader>rd", function() vim.cmd.RustLsp("debuggables") end, "Debuggables")
        end,
      },
    }
  end,
}
