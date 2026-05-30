-- ~/.config/nvim/lua/plugins/completion.lua
-- blink.cmp: the 2026 standard completion engine. Faster than nvim-cmp,
-- batteries-included (LSP + path + snippets + buffer sources), Rust fuzzy
-- matcher. `version = "1.*"` pulls a prebuilt binary so there's nothing to
-- compile.
return {
  "saghen/blink.cmp",
  version = "1.*",
  event = "InsertEnter",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      -- "default" = <C-y> to accept, <C-n>/<C-p> or arrows to navigate,
      -- <C-space> to open/toggle docs. Tab is left to snippets.
      preset = "default",
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },
    appearance = { nerd_font_variant = "mono" },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
      menu = { border = "rounded" },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    -- Use the Rust fuzzy matcher (prebuilt). Falls back to Lua if unavailable.
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = { enabled = true }, -- show function signature while typing args
  },
}
