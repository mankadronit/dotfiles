-- ~/.config/nvim/lua/plugins/lsp.lua
-- LSP setup for Neovim 0.11+/0.12 using the NATIVE LSP API.
--
-- How the pieces fit together (the modern, 2026 way):
--   * mason.nvim          -> installs the language server *binaries*
--   * mason-lspconfig     -> auto-enables installed servers via vim.lsp.enable()
--   * nvim-lspconfig      -> ships the default server definitions Neovim reads
--   * vim.lsp.config(...) -> our per-server overrides (merged with the defaults)
--
-- We do NOT call `require("lspconfig").xxx.setup{}` anywhere — that old wrapper
-- is deprecated in favour of vim.lsp.config / vim.lsp.enable.
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "mason-org/mason-lspconfig.nvim",
    "saghen/blink.cmp", -- so we can advertise its completion capabilities
  },
  config = function()
    -- 1. Diagnostics appearance ------------------------------------------------
    vim.diagnostic.config({
      severity_sort = true,
      float = { border = "rounded", source = "if_many" },
      underline = true,
      virtual_text = { source = "if_many", spacing = 2 },
      signs = vim.g.have_nerd_font and {
        text = {
          [vim.diagnostic.severity.ERROR] = "󰅚 ",
          [vim.diagnostic.severity.WARN] = "󰀪 ",
          [vim.diagnostic.severity.INFO] = "󰋽 ",
          [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
      } or {},
    })

    -- 2. Keymaps, applied per-buffer when a server attaches --------------------
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, fn, desc, mode)
          vim.keymap.set(mode or "n", keys, fn, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Navigation uses the snacks picker for a nice list UI.
        map("gd", function() Snacks.picker.lsp_definitions() end, "Goto definition")
        map("gD", vim.lsp.buf.declaration, "Goto declaration")
        map("grr", function() Snacks.picker.lsp_references() end, "References")
        map("gri", function() Snacks.picker.lsp_implementations() end, "Goto implementation")
        map("gy", function() Snacks.picker.lsp_type_definitions() end, "Type definition")
        map("<leader>cs", function() Snacks.picker.lsp_symbols() end, "Document symbols")

        -- Actions
        map("K", vim.lsp.buf.hover, "Hover docs")
        map("grn", vim.lsp.buf.rename, "Rename")
        map("gra", vim.lsp.buf.code_action, "Code action", { "n", "x" })

        -- Inlay hints toggle (if the server supports them, e.g. rust-analyzer).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method("textDocument/inlayHint") then
          map("<leader>ch", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
          end, "Toggle inlay hints")
        end

        -- Let basedpyright own hover/formatting; ruff is lint + organise only.
        if client and client.name == "ruff" then
          client.server_capabilities.hoverProvider = false
        end
      end,
    })

    -- 3. Capabilities advertised to servers (extended by blink.cmp) ------------
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    -- 4. Per-server settings ---------------------------------------------------
    -- These are merged on top of nvim-lspconfig's defaults. They are registered
    -- BEFORE mason-lspconfig.setup() so automatic_enable picks them up.
    vim.lsp.config("*", { capabilities = capabilities })

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          completion = { callSnippet = "Replace" },
          -- Stop "undefined global vim" warnings in Neovim config files.
          diagnostics = { globals = { "vim", "Snacks" } },
          workspace = { checkThirdParty = false },
        },
      },
    })

    vim.lsp.config("basedpyright", {
      settings = {
        basedpyright = {
          analysis = {
            typeCheckingMode = "basic", -- "standard"/"strict" once you're ready
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "openFilesOnly",
          },
        },
      },
    })

    -- ruff: linter + import-sorter. Formatting is handled by conform.nvim.
    vim.lsp.config("ruff", {})

    -- NOTE: Rust is intentionally absent here. rustaceanvim (lua/plugins/rust.lua)
    -- owns rust-analyzer end-to-end; enabling it via mason-lspconfig too would
    -- attach the server twice.

    -- 5. Install + auto-enable -------------------------------------------------
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "basedpyright",
        "ruff",
        -- Broader coverage (defaults are fine; rust stays with rustaceanvim).
        -- Go: enable with `brew install go` then `:MasonInstall gopls` (omitted
        -- here so Mason doesn't retry a failing install without the toolchain).
        "ts_ls", -- TypeScript / JavaScript
        "clangd", -- C / C++
        "dockerls", -- Dockerfile
        "yamlls", -- YAML
      },
      -- automatic_enable = true is the default: installed servers get
      -- vim.lsp.enable()'d automatically, using the configs defined above.
    })
  end,
}
