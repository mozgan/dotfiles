--- Install lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Configure lazy.nvim
require("lazy").setup({
  debug = false,
  spec = {
    { import = "base" },
    { import = "ui" },
    { import = "devel" },
    --{ import = "lang" },
  },
  defaults = { lazy = true, version = nil },
  install = {
    missing = true, -- -- install missing plugins on startup
    colorscheme = { "tokyonight", "catppuccin", "PaperColor", "gruvbox-material" }
  },
  checker = {
    enabled = true,  -- automatically check for plugin updates
    notify = true,
    --frequency = 3600, -- check for updates every hour
    --concurrency = nil, ---@type number? set to 1 to check for updates very slowly
  },
  --change_detection = {
  --  enabled = true,
  --  notify = true,
  --},
  ui = {
    size = { width = 0.8, height = 0.8 },
    wrap = "true",
    icons = {
      loaded = '●',
      not_loaded = '○',
      cmd = ' ',
      config = '',
      event = '',
      ft = ' ',
      init = ' ',
      keys = ' ',
      plugin = ' ',
      runtime = ' ',
      source = ' ',
      start = '',
      task = '✔ ',
      lazy = '󰒲 ',
      list = { '●', '➜', '★', '‒' },
    },
  },
  performance = {
    cache = { enabled = true, },
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

--vim.keymap.set('n', '<leader>l', '<cmd>:Lazy<cr>',
--  { noremap = true, silent = true, desc = "Lazy" }
--)


