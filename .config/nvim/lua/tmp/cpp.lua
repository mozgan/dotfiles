if not require("config").lang.cpp then
  return {}
end

local function get_codelldb()
  local mason_registry = require "mason-registry"
  local codelldb = mason_registry.get_package "codelldb"
  local extension_path = codelldb:get_install_path() .. "/extension/"
  local codelldb_path = extension_path .. "adapter/codelldb"
  local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
  return codelldb_path, liblldb_path
end

local lsp_utils = require("devel.lsp.utils")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "c", "cpp" })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "codelldb" })
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      table.insert(opts.sources, nls.builtins.formatting.clang_format)
      --table.insert(opts.sources, nls.builtins.diagnostics.clang_check)
      table.insert(opts.sources, nls.builtins.diagnostics.cpplint.with({
        args = { "--filter=-legal,-build/include_subdir,-build/namespaces,-build/c++11,-whitespace/comments", "$FILENAME" }
      }))
      print(vim.inspect(opts.sources))
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          on_attach = lsp_utils.on_attach,
          capabilities = lsp_utils.capabilities,
--          cmd = {
--            "clangd",
--            "--background-index",
--            "--clang-tidy",
--            "--completion-style=bundled",
--            "--cross-file-rename",
--            "--header-insertion=iwyu",
--            "--fallback-style=Google",
--          },
          cmd = { 'clangd',
            "--fallback-style=Google",
            '--background-index',
            '--header-insertion=iwyu',
            '--completion-style=detailed',
            '--pch-storage=memory',
            '--clang-tidy',
            '--header-insertion-decorators',
            '--all-scopes-completion',
            '--offset-encoding=utf-16',
            '--limit-results=250',
            '-j=2',
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
          flags = { debounce_text_changes = 150 },
          filetypes = { "c", "cpp", "cc", "h", "hpp" },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    opts = {
      setup = {
        codelldb = function()
          local codelldb_path, _ = get_codelldb()
          local dap = require "dap"
          dap.adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = {
              command = codelldb_path,
              args = { "--port", "${port}" },

              -- On windows you may have to uncomment this:
              -- detached = false,
            },
          }
          dap.configurations.cpp = {
            {
              name = "Launch file",
              type = "codelldb",
              request = "launch",
              program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
              end,
              cwd = "${workspaceFolder}",
              stopOnEntry = false,
            },
          }

          dap.configurations.c = dap.configurations.cpp
          dap.configurations.rust = dap.configurations.cpp
        end,
      },
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      { "alfaix/neotest-gtest", opts = {} },
    },
    opts = function(_, opts)
      vim.list_extend(opts.adapters, {
        require "neotest-gtest",
      })
    end,
  },
}

