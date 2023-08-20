return {
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gdiffsplit", "Gvdiffsplit" },
    --dependencies = { -- :GBrowse
    --  "tpope/vim-rhubarb",
    --},
    -- stylua: ignore
    keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "Status" },
      { "<leader>gd", "<cmd>Gvdiffsplit<cr>", desc = "Diff" },
    },
  },
  { -- which-key
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      defaults = {
        mode = { "n" },
        ["<leader>g"] = { name = "+Git" },
      },
    },
    config = function(_, opts)
      local which_key = require("which-key")
      which_key.register(opts.defaults)
    end,
  },
}
