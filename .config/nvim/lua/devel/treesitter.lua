return {
  { -- treesitter
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
      --"HiPhish/nvim-ts-rainbow2", -- TODO:
    },
    opts = {
      sync_install = false,
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "cmake",
        "diff",
        "dockerfile",
        "git_config",
        "gitcommit",
        "gitignore",
        "json",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        "vim",
        "yaml",
      },
      highlight = {
        enable = true,
        -- vim syntax + treesitter syntax? (true/false/list-of-languages)
        additional_vim_regex_highlighting = { "org", "markdown" },
      },
      indent = { enable = true },
      context_commentstring = { enable = true, enable_autocmd = false },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },

      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
          },
        },
      },
      -- TODO:
      --rainbow = {
      --  enable = true,
      --  query = 'rainbow-parens',
      --  strategy = require('ts-rainbow').strategy.global,
      --},
      matchup = {
        enable = true,
      },
    },
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter", event = "VeryLazy" },
    },
    opts = {
      space_char_blankline = " ",
      char = "▏",
      --char = "┊",
      show_trailing_blankline_indent = false,
      show_first_indent_level = true,
      use_treesitter = true,
      show_current_context = true,
      show_current_context_start = true,
      show_end_of_line = true,
      buftype_exclude = { "terminal", "nofile" },
      filetype_exclude = { "help", "NvimTree" },
    },
    config = function(_, opts)
      vim.opt.termguicolors = true
      require("indent_blankline").setup(opts)
    end,
  },
}


