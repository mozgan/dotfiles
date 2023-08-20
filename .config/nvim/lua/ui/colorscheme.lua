return {
  { -- tokyonight
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    name = "tokyonight",
    opts = {
      style = "night",
      transparent = false,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    --config = function(_, opts)
    --  local tokyonight = require("tokyonight")
    --  tokyonight.setup(opts)
    --  tokyonight.load()
    --end,
  },
  { -- catppuccin
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },
      transparent_background = false,
    },
    --config = function(_, opts)
    --  local catppuccin = require("catppuccin")
    --  catppuccin.setup(opts)
    --  catppuccin.load()
    --end,
  },
  { -- gruvbox-material
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    name = "gruvbox-material",
    config = function()
      vim.cmd([[
        let g:gruvbox_material_background = "hard"
        let g:gruvbox_material_better_performance = 1
        colorscheme gruvbox-material
      ]])
    end,
  },
  { -- papercolor
    "NLKNguyen/papercolor-theme",
    lazy = false,
    priority = 1000,
    name = "PaperColor",
    --opts = true,
    --config = function()
    --  vim.cmd([[colorscheme PaperColor]])
    --end,
  },
}

