return {
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    opts = {
      manual_mode = true, -- `:ProjectRoot` command changes the root directory
      silent_chdir = false,
    },
    config = function(_, opts)
      require("project_nvim").setup(opts)
    end,
  },
}
