-- Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

local options = {
  autoindent = true, -- indent a new line the same amount as the line just typed
  autoread = true,
  autowrite = true,
  autowriteall = true,
  backup = true, -- creates a backup file
  backupdir = vim.fn.expand("$HOME/tmp/backup"),
  backspace = { "indent", "eol", "start" },
  breakindent = true,
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  cmdheight = 0, -- more space in the neovim command line for displaying messages
  colorcolumn = "80", -- set color column 80
  completeopt = { "menu", "menuone", "noinsert", "noselect" }, -- mostly just for cmp
  conceallevel = 0, -- so that `` is visible in markdown files
  confirm = true, -- confirm to save changes before exiting modified buffer
  cursorline = true, -- highlight the current line
  directory = vim.fn.expand("$HOME/tmp/swap"),
  encoding = "utf-8", -- the encoding written to a file
  errorbells = false, -- no error bells
  expandtab = true, -- convert tabs to spaces
  fileencoding = "utf-8", -- the encoding written to a file
  fileformats = "unix,dos,mac",
  fillchars = {
    diff = "",
    fold = " ",
    eob = " ",
    horiz = "━",
    horizup = "┻",
    horizdown = "┳",
    vert = "┃",
    msgsep = '─',
    vertleft = "┫",
    vertright = "┣",
    verthoriz = "╋",
    --foldclose = "",
    foldclose = "▸",
    --foldopen = "",
    foldopen = "▾",
    --foldsep = " ",
    foldsep = "│",
  },
  foldcolumn = "1", -- '0' is not bad
  foldenable = true,
  foldlevel = 99, -- Using ufo provider need a large value, feel free to decrease the value
  foldlevelstart = 99,
  --formatoptions = "jcroqlnt", -- tcqj
  formatoptions = {
    ["1"] = true,
    ["2"] = true,
    q = true,
    c = true,
    r = true,
    n = true,
    t = false,
    j = true,
    l = true,
    v = true,
  },
  grepformat = "%f:%l:%c:%m",
  grepprg = "rg --vimgrep",
  hidden = true, -- show hidden buffers
  hlsearch = true, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  inccommand = "nosplit", -- preview incremental substitute
  incsearch = true,
  joinspaces = false,
  laststatus = 0, -- disable status line
  linebreak = true,
  list = false, -- show some invisible characters (tabs...
  mouse = "a", -- enable mouse click and middle-click paste with
  -- mousemoveevent = true,
  number = true, -- set numbered lines
  numberwidth = 4, -- set number column width {default 4}
  pumblend = 10, -- popup blend
  pumheight = 10, -- pop up menu height
  relativenumber = false, -- set relative numbered lines
  scrollback = 100000,
  scrolloff = 4, -- min. number of screen lines to keep above and below the cursor
  sessionoptions = { "buffers", "curdir", "help", "tabpages", "terminal", "globals", "winsize" },
  -- shell = "zsh", -- /bin/bash
  shiftround = true, -- round indent
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  shortmess = {
    t = true,
    A = true,
    o = true,
    O = true,
    T = true,
    f = true,
    F = true,
    s = true,
    W = true,
    c = true,
  },
  showbreak = "»",
  showcmd = false,
  showmatch = true, -- show matching
  showmode = false, -- don't need to see things like -- INSERT -- anymore
  showtabline = 2, -- always show tabs
  sidescrolloff = 4, -- min. number of screen columns to keep to the left and right of the cursor
  signcolumn = "yes",
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  softtabstop = 0, -- soft tab stop
  splitbelow = true, -- force all horizontal splits to go below current window
  splitkeep = "screen",
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  syntax = "on",
  tabstop = 2, -- insert 2 spaces for a tab
  termguicolors = true, -- set term gui colors (most terminals support this)
  textwidth = 80,
  timeout = true,
  timeoutlen = 300, -- time to wait for a mapped sequence to complete (in milliseconds)
  title = true, -- show title in terminal header
  ttyfast = true,
  undofile = true, -- enable persistent undo
  undodir = vim.fn.expand("$HOME/tmp/undo"),
  undolevels = 100000, -- Maximum number of changes that can be undone
  updatetime = 200, -- faster completion (4000ms default)
  wildignore = {
    "*DS_STORE",
    ".aux",
    "*.db",
    "*.docx",
    "*.exe",
    "*.flv",
    "*.gif",
    "*.jpg",
    "*.img",
    ".lock",
    "*.o",
    "*.out",
    "*.png",
    "*.pdf",
    "*.pyc",
    "*.rar",
    "*.tar.xz",
    ".toc",
    "*.xlsx",
    "*.zip",
  },
  wildmode = "longest:full,full", -- command-line completion mode
  wrap = false, -- display lines as one long line
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

for k, v in pairs(options) do
  opt[k] = v
end

--opt.listchars:append { tab = "»­", trail = "·", eol = "↴", precedes = "«", extends = "»", nbsp = "·" }
--opt.shortmess = "filnxtToSOFWIcC"
--opt.shortmess:append { W = true, I = true, c = true, C = true }

opt.guifont = "MesloLGS NF Regular Nerd Font Complete 12" -- the font used in graphical neovim applications
--opt.guifont = "Cascadia Code Italic 12" -- the font used in graphical neovim applications
-- opt.guicursor="n-v-c-sm:block-blinkwait300-blinkon200-blinkoff150,i-ci-ve:ver25,r-cr-o:hor20" -- cursorstyle
opt.guicursor = "n-ci:hor30-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor30-Cursor,a:blinkon100"

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0


