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
      --context_commentstring = { enable = true, enable_autocmd = false },
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
    main = "ibl",
    highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
        "CursorColumn",
        "Whitespace",
    },
    opts = {
      indent = {
        highlight = highlight,
        char = "▏",
      },
      whitespace = {
        highlight = highlight,
      --  remove_blankline_trail = false,
      },
      scope = {
        highlight = highlight,
      --  enabled = false
      },
      exclude = {
        buftypes = { "terminal", "nofile" },
        filetypes = { "help", "NvimTree" },
      },
    },
    config = function(_, opts)
      vim.opt.termguicolors = true

      local hooks = require("ibl.hooks")

      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)


      vim.g.rainbow_delimiters = { highlight = highlight }

      require("ibl").setup(opts)
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },
}


