return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      defaults = {
        ["<leader>l"] = { name = "+LSP" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "j-hui/fidget.nvim", tag = "legacy"}, --config = true },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {
      servers = {},
      setup = {},
      format = {
        timeout_ms = 3000,
      },
    },
    config = function(plugin, opts)
      require("devel.lsp.servers").setup(plugin, opts)
    end,
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = "Mason",
    opts = {
      ensure_installed = {
        "shfmt",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")

      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      local formatting = nls.builtins.formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      local diagnostics = nls.builtins.diagnostics
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#completion
      local completion = nls.builtins.completion
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#code-actions
      local code_actions = nls.builtins.code_actions

      return {
        --debug = true,
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          -- General
          code_actions.refactoring,
          code_actions.gitsigns,
          completion.luasnip,
          formatting.prettier,

          -- Shell
          formatting.shfmt.with({ extra_args = { "-i 4" } }),

          -- Markdown
          --formatting.remark,
          diagnostics.proselint,

          -- Python
          diagnostics.flake8,
          formatting.isort,
          --formatting.black,
          formatting.black.with({ extra_args = { "--fast" } }),

          -- C++
          formatting.clang_format.with({
            args = { "-style=Google" }
          }),
          --diagnostics.clang_check,
          diagnostics.cpplint.with({
            args = { "--filter=-legal,-build/include_subdir,-build/namespaces,-build/c++11,-whitespace/comments", "$FILENAME" }
          }),

          -- CMake
          formatting.cmake_format,
          diagnostics.cmake_lint,

          -- Lua
          diagnostics.trail_space,

          -- JSON
          diagnostics.jsonlint,
          formatting.jq,
        },
      }
    end,
  },
}

