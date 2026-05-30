-- ~/.config/nvim/lua/plugins/treesitter.lua
-- Treesitter: fast, accurate syntax highlighting + indentation.
--
-- IMPORTANT (2026): the old `master` branch is archived and its queries are
-- incompatible with Neovim 0.11+/0.12. We use the `main` branch, whose API is:
--   * require("nvim-treesitter").install({ langs })  -- install parsers
--   * vim.treesitter.start()                         -- enable highlighting
-- Highlighting is opt-in per buffer via a FileType autocmd (the main branch
-- intentionally does not lazy-load or auto-enable).
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ensure_installed = {
      "python",
      "rust",
      "lua",
      "luadoc",
      "vim",
      "vimdoc",
      "bash",
      "fish",
      "toml",
      "json",
      "yaml",
      "markdown",
      "markdown_inline",
      "git_config",
      "gitcommit",
      "diff",
      -- Broader language coverage
      "go",
      "gomod",
      "gosum",
      "javascript",
      "typescript",
      "tsx",
      "c",
      "cpp",
      "dockerfile",
      "html",
      "css",
    }

    -- Install any missing parsers (async; no-op for already-installed ones).
    require("nvim-treesitter").install(ensure_installed)

    -- Turn on highlighting + treesitter indentation when a buffer's filetype
    -- is set, but only if a parser for that language is actually available.
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
      callback = function(ev)
        local lang = vim.treesitter.language.get_lang(ev.match)
        if not lang then
          return
        end
        -- language.add returns false if no parser is installed for `lang`.
        if not pcall(vim.treesitter.language.add, lang) then
          return
        end
        pcall(vim.treesitter.start, ev.buf, lang)
        -- Treesitter-based indentation (experimental). Remove this line if you
        -- ever find indentation behaving oddly for a particular language.
        vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
