return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    cmd = "Copilot",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<Tab>",
        },
      },
      panel = {
        enabled = true,
        auto_refresh = true,
      },
    },
    config = function(_, opts)
      require("copilot").setup(opts)
    end,
  },
--[[
  {
    "zbirenbaum/copilot-cmp",
    opts = {
      sources = {
        -- Copilot Source
        { name = "copilot", group_index = 2 },
        -- Other Sources
        { name = "nvim_lsp", group_index = 2 },
        { name = "path", group_index = 2 },
        { name = "luasnip", group_index = 2 },
      },
    },
    config = function (_, opts)
      require("copilot_cmp").setup()
    end,
    --"github/copilot.vim",
  }
--]]
}
