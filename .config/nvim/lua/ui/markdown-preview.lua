return {
  "iamcco/markdown-preview.nvim",
  event = "VeryLazy",
  dependencies = { "ekickx/clipboard-image.nvim" },
  build = "cd app && npm install",
  ft = { "markdown" },
  config = function()
    vim.cmd([[
      "let g:mkdp_theme = 'dark'
      let g:mkdp_theme = 'light'
      let g:mkdp_auto_close = 0
    ]])

    local image = require("clipboard-image")

    image.setup({
      -- Default configuration for all filetype
      default = {
        img_dir = "images",
        img_name = function() return os.date("%Y-%m-%d-%H-%M-%S") end, -- Example result: "2021-04-13-10-04-18"
        affix = "<\n  %s\n>"                                           -- Multi lines affix
      },
      markdown = {
        img_dir = { "%:p:h", "images" }, -- Use table for nested dir (New feature form PR #20)
        img_dir_txt = "images",
        --[[ img_handler = function(img) -- New feature from PR #22 ]]
        --[[   local script = string.format('./image_compressor.sh "%s"', img.path) ]]
        --[[   os.execute(script) ]]
        --[[ end, ]]
      }
    })
  end,
}


